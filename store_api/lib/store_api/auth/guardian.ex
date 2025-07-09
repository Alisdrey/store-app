defmodule StoreApiWeb.Auth.Guardian do
  use Guardian, otp_app: :store_api

  alias StoreApi.Accounts
  alias StoreApi.Accounts.User

  def subject_for_token(%User{id: id}, _claims), do: {:ok, to_string(id)}
  def resource_from_claims(%{"sub" => id}), do: {:ok, Accounts.get_user!(id)}
end
