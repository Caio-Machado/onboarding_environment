defmodule ApiProducts.RedisService do
  def set_product(product) do
    Redix.command(:redis_server, ["SET", "product:#{product.id}", encode(product)])
  end

  def get_product(id) do
    case Redix.command(:redis_server, ["GET", "product:#{id}"]) do
      {:ok, nil} -> {:ok, nil}

      {:ok, result} -> {:ok, decode(result)}

      error -> error
    end
  end

  def delete_product(id) do
    case get_product(id) do
      {:ok, _} -> Redix.command(:redis_server, ["DEL", "product:#{id}"])

      error -> error
    end
  end

  defp encode(product), do: product |> :erlang.term_to_binary() |> Base.encode16()

  defp decode(product) do
    {_, result} = Base.decode16(product)
    :erlang.binary_to_term(result)
  end
end
