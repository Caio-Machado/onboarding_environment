defmodule ApiProductsWeb.ProductsController do
  use ApiProductsWeb, :controller

  alias ApiProducts.Management

  action_fallback ApiProductsWeb.FallbackController

  plug :product_exists? when action in [:show, :update, :delete]

  def index(conn, _params) do
    products = Management.list_products()
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"product" => product_params}) do
    case Management.create_product(product_params) do
      {:ok, result} ->
        conn
        |> put_status(:created)
        |> render("show.json", product: result)
      {:error, result} ->
        {:error, result}
    end
  end

  def show(conn, %{"id" => id}) do
    render(conn, "show.json", product: conn.assigns[:product])
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    case conn.params["id"] |> Management.get_product() |> Management.update_product(product_params) do
      {:ok, _} -> json(conn, %{:ok => "The product with id #{conn.params["id"]} has updated!"})
      {:error, result} -> {:error, result}
    end
  end

  def delete(conn, %{"id" => id}) do
    case conn.params["id"] |> Management.get_product() |> Management.delete_product() do
      {:ok, _} -> json(conn, %{:ok => "The product with id #{conn.params["id"]} has deleted!"})
      {:error, result} -> {:error, result}
    end
  end

  defp product_exists?(conn, _) do
    product = Management.get_product(conn.params["id"])
    case product do
      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(ApiProductsWeb.ErrorView)
        |> render(:"404")
      %ApiProducts.Management.Products{} ->
        assign(conn, :product, product)
    end
  end
end
