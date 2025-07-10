defmodule StoreApiWeb.Plugs.AuthPlug do
  import Plug.Conn
  import Phoenix.Controller

  alias StoreApiWeb.ErrorJSON
  alias StoreApi.Auth

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_req_header(conn, "authorization") do
      ["Bearer " <> token] ->
        with {:ok, claims} <- Auth.verify_token(token),
             {:ok, user} <- Auth.resource_from_claims(claims) do
          assign(conn, :current_user, user)
        else
          _ -> unauthorized(conn)
        end

      _ ->
        unauthorized(conn)
    end
  end

  defp unauthorized(conn) do
    conn
    |> put_status(:unauthorized)
    |> put_view(StoreApiWeb.ErrorJSON)
    |> render("401.json")
    |> halt()
  end
end
