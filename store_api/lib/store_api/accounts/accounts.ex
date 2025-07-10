defmodule StoreApi.Accounts do
  import Ecto.Query, warn: false
  alias StoreApi.Repo
  alias StoreApi.Accounts.User
  alias Bcrypt

  def get_user_by_email(email), do: Repo.get_by(User, email: email)

  def get_user(id), do: Repo.get(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_user(email, password) do
    with %User{} = user <- get_user_by_email(email),
        true <- Bcrypt.verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      _ -> {:error, :unauthorized}
    end
  end
end
