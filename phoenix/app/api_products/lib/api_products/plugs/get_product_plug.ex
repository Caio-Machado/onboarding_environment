defmodule ApiProducts.GetProductPlug do
  use ApiProductsWeb, :controller
  import Plug.Conn

  alias ApiProducts.Management

  def init(props) do
    props
  end

  def call(conn, _) do
    conn.params["id"]
    |> Management.get_product()
    |> verify_product(conn)
  end

  defp verify_product(%ApiProducts.Management.Products{} = product, conn), do: assign(conn, :product, product)

  defp verify_product(nil, conn) do
    conn
    |> put_status(404)
    |> put_view(ApiProductsWeb.ErrorView)
  end

  defp verify_product(_, conn) do
    conn
    |> put_status(500)
    |> put_view(ApiProductsWeb.ErrorView)
  end
end
