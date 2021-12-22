defmodule ApiProductsWeb.RedisController do
  def set(all_products) do
    Redix.command(:redis_server, ["SET", "products:index", encode(all_products)])
  end

  def get() do
    case Redix.command(:redis_server, ["GET", "products:index"]) do
      {:ok, nil} -> {:error, :not_found}
      {:ok, result} -> {:ok, decode(result)}
    end
  end

  def delete(), do: Redix.command(:redis_server, ["DEL", "poducts:index"])

  defp encode(product), do: product |> :erlang.term_to_binary() |> Base.encode16()

  defp decode(product) do
    {_, result} = Base.decode16(product)
    :erlang.binary_to_term(result)
  end
end
