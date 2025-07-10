defmodule StoreApi.Auth.Guardian do
  use Guardian, otp_app: :store_api

  alias StoreApi.Accounts

  def subject_for_token(user, _claims), do: {:ok, user.id}
  def resource_from_claims(%{"sub" => id}), do: {:ok, Accounts.get_user!(id)}
end
