defmodule ApiProductsWeb.ProductsController do
  use ApiProductsWeb, :controller

  alias ApiProducts.Management
  alias ApiProductsWeb.RedisHelper
  alias ApiProductsWeb.ElasticSearchHelper

  action_fallback(ApiProductsWeb.FallbackController)

  plug(:fetch_product when action in [:show, :update, :delete])

  def index(conn, _params) do
    case RedisHelper.set_products(Management.list_products()) do
      {:ok, _} ->
        {:ok, result} = RedisHelper.get_products()
        conn
        |> render("index.json", products: result)
        |> ElasticSearchHelper.save_log()

      error -> error
    end
  end

  def create(conn, %{"product" => product_params}) do
    case Management.create_product(product_params) do
      {:ok, result} ->
        conn
        |> put_status(:created)
        |> render("show.json", product: result)
        |> ElasticSearchHelper.save_log()

      error -> error
    end

  end

  def show(conn, _) do
    render(conn, "show.json", product: conn.assigns[:product])
  end

  def update(conn, %{"id" => _, "product" => product_params}) do
    case Management.update_product(conn.assigns[:product], product_params) do
      {:ok, _} ->
        conn
        |> send_resp(204, "")
        |> ElasticSearchHelper.save_log()

      error -> error
    end
  end

  def delete(conn, _) do
    case Management.delete_product(conn.assigns[:product]) do
      {:ok, _} ->
        conn
        |> send_resp(204, "")
        |> ElasticSearchHelper.save_log()

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
        |> ElasticSearchHelper.save_log()

      %ApiProducts.Management.Products{} ->
        assign(conn, :product, product)
    end
  end
end
