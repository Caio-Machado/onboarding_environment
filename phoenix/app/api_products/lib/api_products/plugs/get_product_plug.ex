defmodule ApiProducts.GetProductPlug do
  use ApiProductsWeb, :controller
  import Plug.Conn

  alias ApiProducts.Management
  alias ApiProducts.RedisService

  def init(props) do
    props
  end

  def call(conn, _) do
    conn.params["id"]
    |> RedisService.get_product()
    |> verify_redis(conn)
    |> verify_product(conn)
  end

  defp verify_redis({:ok, nil}, conn) do
    with %ApiProducts.Management.Products{} = product <- Management.get_product(conn.params["id"]) do
      RedisService.set_product(product)
      product
    end
  end

  defp verify_redis({:ok, result}, _conn), do: result

  defp verify_redis({:error, _}, conn), do: Management.get_product(conn.params["id"])

  defp verify_redis(result, _), do: result

  defp verify_product(%ApiProducts.Management.Products{} = product, conn) do
    assign(conn, :product, product)
  end

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
