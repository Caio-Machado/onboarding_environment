defmodule ApiProductsWeb.ProductsController do
  use ApiProductsWeb, :controller

  alias ApiProducts.ProductsService

  action_fallback(ApiProductsWeb.FallbackController)

  plug(ApiProducts.GetProductPlug when action in [:show, :update, :delete])

  plug(ApiProducts.SaveLogPlug)

  def index(conn, _) do
    with {:ok, response} <- ProductsService.list() do
      conn
      |> render("index.json", products: response)
    end
  end

  def create(conn, %{"product" => product_params}) do
    with {:ok, response} <- ProductsService.create(product_params) do
      conn
      |> put_status(:created)
      |> render("show.json", product: response)
    end
  end

  def show(conn, _) do
    with {:ok, product} <- ProductsService.show(conn.assigns[:product]) do
      render(conn, "show.json", product: product)
    end
  end

  def update(conn, %{"id" => _, "product" => product_params}) do
    with {:ok, _} <- ProductsService.update(conn.assigns[:product], product_params) do
      send_resp(conn, 204, "")
    end
  end

  def delete(conn, _) do
    with {:ok, _} <- ProductsService.delete(conn.assigns[:product]) do
      send_resp(conn, 204, "")
    end
  end
end
