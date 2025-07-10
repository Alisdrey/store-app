defmodule StoreApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bcrypt

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Jason.Encoder, only: [:id, :email]}
  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "is not a valid email")
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case get_change(changeset, :password) do
      nil -> changeset
      pw -> put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(pw))
    end
  end
end
