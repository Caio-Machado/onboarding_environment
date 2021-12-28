defmodule ApiProductsWeb.RedisService do
  def set_products(all_products) do
    Redix.command(:redis_server, ["SET", "products:index", encode(all_products)])
  end

  def get_products() do
    case Redix.command(:redis_server, ["GET", "products:index"]) do
      {:ok, nil} -> {:ok, nil}

      {:ok, result} -> {:ok, decode(result)}

      error -> error
    end
  end

  def delete_products() do
    case get_product() do
      {:ok, _} -> Redix.command(:redis_server, ["DEL", "products:index"])

      error -> error
    end

  defp encode(product), do: product |> :erlang.term_to_binary() |> Base.encode16()

  defp decode(product) do
    {_, result} = Base.decode16(product)
    :erlang.binary_to_term(result)
  end
end
