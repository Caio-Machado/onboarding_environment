defmodule ApiProductsWeb.ProductsController do
  use ApiProductsWeb, :controller

  alias ApiProducts.Management
  alias ApiProductsWeb.RedisController
  alias ApiProductsWeb.LogstashController

  action_fallback(ApiProductsWeb.FallbackController)

  plug(:fetch_product when action in [:show, :update, :delete])

  def index(conn, _params) do
    case RedisController.get() do
      {:error, :not_found} ->
        products = Management.list_products()
        RedisController.set(products)
        conn
        |> render("index.json", products: products)
        |> LogstashController.save_log()
      {:ok, result} ->
        conn
        |> render("index.json", products: result)
        |> LogstashController.save_log()
    end
  end

  def create(conn, %{"product" => product_params}) do
    case Management.create_product(product_params) do
      {:ok, result} ->
        RedisController.set(Management.list_products)
        conn
        |> put_status(:created)
        |> render("show.json", product: result)
        |> LogstashController.save_log()
      error -> error
    end

  end

  def show(conn, _) do
    render(conn, "show.json", product: conn.assigns[:product])
  end

  def update(conn, %{"id" => _, "product" => product_params}) do
    case Management.update_product(conn.assigns[:product], product_params) do
      {:ok, _} ->
        RedisController.set(Management.list_products)
        conn
        |> send_resp(204, "")
        |> LogstashController.save_log()
      error -> error
    end
  end

  def delete(conn, _) do
    case Management.delete_product(conn.assigns[:product]) do
      {:ok, _} ->
        RedisController.set(Management.list_products)
        conn
        |> send_resp(204, "")
        |> LogstashController.save_log()
      error -> error
    end
  end

  defp fetch_product(conn, _) do
    product = Management.get_product(conn.params["id"])

    case product do
      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(ApiProductsWeb.ErrorView)
        |> render(:"404")
        |> halt()
        |> LogstashController.save_log()

      %ApiProducts.Management.Products{} ->
        assign(conn, :product, product)
    end
  end
end
