defmodule StoreApiWeb.Router do
  use StoreApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug StoreApiWeb.Plugs.AuthPlug
  end

  scope "/api/auth", StoreApiWeb do
    pipe_through :api

    post "/login", SessionController, :login
  end

  scope "/api", StoreApiWeb do
    pipe_through [:api, :auth]

    resources "/products", ProductController, except: [:new, :edit]
  end
end
