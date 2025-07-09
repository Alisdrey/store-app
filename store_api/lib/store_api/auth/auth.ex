defmodule StoreApi.Auth do
  alias StoreApi.Accounts
  alias StoreApi.Accounts.User

  def authenticate_user(email, password) do
    user = Accounts.get_user_by_email(email)

    cond do
      user && Bcrypt.verify_pass(password, user.password_hash) ->
        {:ok, user}

      true ->
        {:error, :unauthorized}
    end
  end
end
T
