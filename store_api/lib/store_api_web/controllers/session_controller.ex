defmodule StoreApiWeb.SessionController do
  use StoreApiWeb, :controller

  action_fallback StoreApiWeb.FallbackController

  alias StoreApi.Accounts
  alias StoreApiWeb.Auth.Guardian

  def login(conn, %{"email" => email, "password" => password}) do
    with {:ok, user} <- Accounts.authenticate_user(email, password),
        {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      json(conn, %{token: token})
    else
      error ->
        IO.inspect(error, label: "Login Error")
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Login failed"})
    end
  end
end
