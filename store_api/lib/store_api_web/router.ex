defmodule StoreApiWeb.Router do
  use StoreApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", StoreApiWeb do
    pipe_through :api

    post "/login", SessionController, :login
  end

  if Application.compile_env(:store_api, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: StoreApiWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
