defmodule ApiProductsWeb.GetProductPlug do
  use ApiProductsWeb, :controller
  import Plug.Conn

  alias ApiProducts.Management

  def init(props) do
    props
  end

  def call(conn, _) do
    product = Management.get_product(conn.params["id"])

    case product do
      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(ApiProductsWeb.ErrorView)

      %ApiProducts.Management.Products{} ->
        assign(conn, :product, product)
    end
  end
end
