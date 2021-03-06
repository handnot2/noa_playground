defmodule NoaPlayground.Mixfile do
  use Mix.Project

  @version "0.1.0"
  @description "Noa OAuth2 Playground"
  @source_url "https://github.com/handnot2/noa_playground"

  def project do
    [
      app: :noa_playground,
      version: @version,
      description: @description,
      package: package(),
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {NoaPlayground.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:httpoison, "~> 0.13"},
    ]
  end

  defp package() do
    [
      maintainers: ["handnot2"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url,
      }
    ]
  end
end
