defmodule StoreApi.Products do
  import Ecto.Query, warn: false
  alias StoreApi.Repo
  alias StoreApi.Products.Product

  def list_products do
    Repo.all(Product)
  end

  def get_product!(id) do
    Repo.get!(Product, id)
  end

  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end
end
