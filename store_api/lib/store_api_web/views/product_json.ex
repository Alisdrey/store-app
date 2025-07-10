defmodule StoreApiWeb.ProductJSON do

  def index(%{products: products}) do
    %{data: Enum.map(products, &product_json/1)}
  end

  def show(%{product: product}) do
    %{data: product_json(product)}
  end

  defp product_json(product) do
    %{
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      inserted_at: product.inserted_at,
      updated_at: product.updated_at
    }
  end
end
