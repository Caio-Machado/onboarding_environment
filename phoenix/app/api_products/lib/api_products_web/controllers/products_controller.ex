defmodule ApiProductsWeb.ProductsController do
  use ApiProductsWeb, :controller

  alias ApiProducts.Management
  alias ApiProductsWeb.RedisService
  alias ApiProductsWeb.ElasticSearchService
  alias ApiProductsWeb.ProductsService

  action_fallback(ApiProductsWeb.FallbackController)

  plug(ApiProductsWeb.GetProductPlug when action in [:show, :update, :delete])

  def index(conn, _) do
    with {:ok, response} <- ProductsService.confirm_index() do
      conn
      |> render("index.json", products: response)
      |> ElasticSearchService.save_log()
    end
  end

  def create(conn, %{"product" => product_params}) do
    with {:ok, response} <- ProductsService.confirm_create(product_params) do
      conn
      |> put_status(:created)
      |> render("show.json", product: response)
      |> ElasticSearchService.save_log()
    end
  end

  def show(conn, _) do
    render(conn, "show.json", product: conn.assigns[:product])
  end

  def update(conn, %{"id" => _, "product" => product_params}) do
    with {:ok} <- ProductsService.confirm_update(conn.assigns[:product], product_params) do
      conn
      |> send_resp(204, "")
      |> ElasticSearchService.save_log()
    end
  end

  def delete(conn, _) do
    with {:ok} <- ProductsService.confirm_delete(conn.assigns[:product]) do
      conn
      |> send_resp(204, "")
      |> ElasticSearchService.save_log()
    end
  end
end
