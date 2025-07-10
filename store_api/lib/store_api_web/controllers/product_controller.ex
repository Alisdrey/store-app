defmodule StoreApiWeb.ProductController do
  use StoreApiWeb, :controller
  alias StoreApiWeb.Router.Helpers, as: Routes
  alias StoreApi.Products
  alias StoreApi.Products.Product

  action_fallback StoreApiWeb.FallbackController

  def index(conn, _params) do
    products = Products.list_products()
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"product" => product_params}) do
    case Products.create_product(product_params) do
      {:ok, product} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/api/products/#{product.id}")
        |> render("show.json", product: product)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(StoreApiWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    render(conn, "show.json", product: product)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Products.get_product!(id)

    case Products.update_product(product, product_params) do
      {:ok, product} ->
        render(conn, "show.json", product: product)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(StoreApiWeb.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Products.get_product!(id)

    case Products.delete_product(product) do
      {:ok, _product} ->
        send_resp(conn, :no_content, "")

      {:error, _reason} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end
end
