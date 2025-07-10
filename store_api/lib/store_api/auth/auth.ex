defmodule StoreApi.Auth do
  use Guardian, otp_app: :store_api

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

  def subject_for_token(%User{id: id}, _claims), do: {:ok, to_string(id)}
  def subject_for_token(_, _), do: {:error, :invalid_subject}

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_user(id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  def resource_from_claims(_), do: {:error, :invalid_claims}

  def verify_token(token) do
    case decode_and_verify(token) do
      {:ok, claims} ->
        IO.inspect(claims, label: "JWT claims OK")
        {:ok, claims}

      error ->
        IO.inspect(error, label: "JWT decode error")
        error
    end
  end
end
