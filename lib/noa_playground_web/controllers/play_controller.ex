defmodule NoaPlaygroundWeb.PlayController do
  @moduledoc false

  # TODO: Handle SSL
  #
  # SSL
  #
  # opts = [{:ssl_options, [{:cacertfile, pem_path}]}]
  # HTTPoison.post(url, body, headers, hackney: opts)
  #

  use NoaPlaygroundWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def exchange_code(conn, %{
      "base_url"      => base_url,
      "client_id"     => client_id,
      "client_secret" => client_secret,
      "code"          => code
      }) do

    post_params = %{
      "client_id"     => client_id,
      "client_secret" => client_secret,
      "grant_type"    => "authorization_code",
      "code"          => code
    }

    result = HTTPoison.post(base_url <> "/issue",
      {:form, Map.to_list(post_params)},
      %{"Content-Type" => "application/x-www-form-urlencoded"})

    case result do
      {:ok, %HTTPoison.Response{} = resp} ->
        #IO.inspect(resp, label: "Issue OK")
        json(conn, resp.body |> Poison.decode!())
      {:error, %HTTPoison.Error{} = error} ->
        #IO.inspect(error, label: "Issue error")
        send_resp(conn, 500, HTTPoison.Error.message(error))
    end
  end

  def introspect_token(conn, %{
      "base_url"      => base_url,
      "client_id"     => client_id,
      "client_secret" => client_secret,
      "access_token"  => access_token
      }) do

    post_params = %{
      "client_id"      => client_id,
      "client_secret"  => client_secret,
      "token"          => access_token,
      "token_type_hint" => "access_token"
    }

    result = HTTPoison.post(base_url <> "/introspect",
      {:form, Map.to_list(post_params)},
      %{"Content-Type" => "application/x-www-form-urlencoded"})

    case result do
      {:ok, %HTTPoison.Response{} = resp} ->
        #IO.inspect(resp, label: "Introspect OK")
        json(conn, resp.body |> Poison.decode!())
      {:error, %HTTPoison.Error{} = error} ->
        #IO.inspect(error, label: "Introspect error")
        send_resp(conn, 500, HTTPoison.Error.message(error))
    end
  end

  def make_test_req(conn, %{
      "test_req_url"     => req_url,
      "test_req_method"  => req_method,
      "test_req_headers" => req_headers,
      "test_req_content_type" => req_content_type,
      "test_req_content" => req_content,
      "access_token"     => access_token
      }) do
    _supported_methods = [:get, :post, :put, :patch, :delete]
    method = req_method |> String.downcase() |> String.to_existing_atom()
    content = if method in [:post, :put, :patch], do: req_content, else: ""

    headers = parse_headers(req_headers)
    headers = :orddict.store("Content-Type", req_content_type, headers)
    headers = :orddict.store("Authorization", "Bearer " <> access_token, headers)

    result = HTTPoison.request(method, req_url, content, headers)

    case result do
      {:ok, %HTTPoison.Response{} = resp} ->
        send_resp(conn, 200, resp.body)
      {:error, %HTTPoison.Error{} = error} ->
        send_resp(conn, 500, HTTPoison.Error.message(error))
    end
  end

  def testing_testing(conn, _params) do
    {:ok, body, conn} = conn |> Plug.Conn.read_body()
    resp = %{
      method: conn.method,
      params: conn.query_params,
      headers: conn.req_headers |> header_map(),
      body: body
    }
    conn |> put_status(200) |> json(resp)
  end

  defp parse_headers(req_headers) do
    req_headers
    |>  String.trim()
    |>  String.split("\n")
    |>  Enum.map(fn header ->
          case String.split(header, ":", parts: 2) do
            [k, v] -> {String.trim(k), String.trim(v)}
            [k] -> {String.trim(k), ""}
          end
        end)
  end

  defp header_map(headers) do
    headers
    |>  Enum.reduce(%{}, fn {k, v}, acc ->
          case Map.get(acc, k) do
            nil -> Map.put(acc, k, v)
            pv when is_list(pv) ->Map.put(acc, k, pv ++ [v])
            pv -> Map.put(acc, k, [pv, v])
          end
        end)
  end
end
