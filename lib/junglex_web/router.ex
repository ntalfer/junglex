defmodule JunglexWeb.Router do
  use JunglexWeb, :router

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

  scope "/", JunglexWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", JunglexWeb do
    pipe_through :api
    get "/jobs", JobController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", JunglexWeb do
  #   pipe_through :api
  # end

  def swagger_info do
    %{info: %{version: "1.0", title: "Junglex"}}
  end

    scope "/api/swagger" do
      forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :junglex, swagger_file: "swagger.json"
    end
end
