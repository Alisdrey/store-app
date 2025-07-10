defmodule StoreApi.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :description, :string
    field :price, :decimal

    timestamps()
  end

  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :price])
    |> validate_required([:name, :price])
    |> validate_length(:name, min: 3)
    |> validate_number(:price, greater_than: 0)
  end
end
