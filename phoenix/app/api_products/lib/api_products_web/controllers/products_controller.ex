defmodule ApiProductsWeb.ProductsController do
  use ApiProductsWeb, :controller

  alias ApiProducts.Management

  action_fallback ApiProductsWeb.FallbackController

  def index(conn, _params) do
    products = Management.list_myapp_development()
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"product" => product_params}) do
    case {_, result} = Management.create_product(product_params) do
      {:ok, _} -> conn
                       |> put_status(:created)
                       |> render("show.json", product: result)
      _ -> render(conn, "error.json", product: result)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Management.get_product!(id)

    case product do
      nil -> json(conn, %{"error" => "Product not found!"})
      _ -> render(conn, "show.json", product: product)
    end
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Management.get_product!(id)

    case product do
      nil -> json(conn, %{"error" => "Product not found!"})
      _ -> json(conn, %{"menssage" => alter_data(product, product_params)})
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Management.get_product!(id)

    case product do
      nil -> json(conn, %{"error" => "Product not found!"})
      _ -> json(conn, %{"menssage" => alter_data(product)})
    end
  end

  def alter_data(product) do
    {_, r} = Management.delete_product(product)
    "The product with id #{r.id} has successfully deleted!"
  end

  def alter_data(product, product_params) do
    {_, r} = Management.update_product(product, product_params)
    "The product with id #{r.id} has updated!"
  end
end
