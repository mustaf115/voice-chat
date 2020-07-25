defmodule VoiceChatWeb.Router do
  use VoiceChatWeb, :router

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

  scope "/", VoiceChatWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/signup", UserController, :new
    resources "/users", UserController, only: [:create, :delete]
    resources "/session", SessionController, only: [:create, :delete], singleton: true
  end

  scope "/chat", VoiceChatWeb do
    pipe_through [:browser, :authenticate_user, :prevent_caching]

    get "/", ChatController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", VoiceChatWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: VoiceChatWeb.Telemetry
    end
  end

  defp authenticate_user(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> Phoenix.Controller.put_flash(:error, "Login required")
        |> Phoenix.Controller.redirect(to: "/")
        |> halt()
      user_email ->
        conn
    end
  end

  defp prevent_caching(conn, _) do
    conn
    |> put_resp_header("cache-control", "no-cache, no-store, must-revalidate")
    |> put_resp_header("pragma", "no-cache")
    |> put_resp_header("expires", "0")
  end
end
