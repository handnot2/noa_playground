defmodule NoaPlaygroundWeb.Router do
  use NoaPlaygroundWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NoaPlaygroundWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PlayController, :index
  end

  scope "/api", NoaPlaygroundWeb do
    pipe_through :api
    post "/exchange_code", PlayController, :exchange_code
    post "/introspect_token", PlayController, :introspect_token
    post "/make_test_req", PlayController, :make_test_req
    post "/testing_testing", PlayController, :testing_testing
  end
end
