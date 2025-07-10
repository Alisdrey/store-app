defmodule StoreApi.Accounts do
  import Ecto.Query, warn: false
  alias StoreApi.Repo
  alias StoreApi.Accounts.User
  alias Bcrypt

  def get_user_by_email(email), do: Repo.get_by(User, email: email)

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_user(email, password) do
    user = get_user_by_email(email)

    cond do
      user && Bcrypt.verify_pass(password, user.password_hash) ->
        {:ok, user}

      true ->
        {:error, :unauthorized}
    end
  end
end
