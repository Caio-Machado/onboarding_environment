defmodule ApiProducts.ProductsService do
  require ApiProductsWeb

  alias ApiProducts.Management
  alias ApiProducts.RedisService

  def list() do
    case RedisService.get_products() do
      {:ok, nil} ->
        RedisService.set_products(Management.list_products())
        RedisService.get_products()

      {:ok, result} -> {:ok, result}

      {:error, _} -> {:ok, Management.list_products()}
    end
  end

  def create(product_params) do
    product_params
    |> Management.create_product
    |> delete_redis_key()
  end

  def show(nil), do: {:error, :not_found}

  def show(%ApiProducts.Management.Products{} = product), do: {:ok, product}

  def update(nil, _), do: {:error, :not_found}

  def update(%ApiProducts.Management.Products{} = product, product_params) do
    product
    |> Management.update_product(product_params)
    |> delete_redis_key()
  end

  def delete(nil), do: {:error, :not_found}

  def delete(%ApiProducts.Management.Products{} = product) do
    product
    |> Management.delete_product()
    |> delete_redis_key()
  end

  defp delete_redis_key({:ok, result}) do
    RedisService.delete_products()
    {:ok, result}
  end

  defp delete_redis_key(result), do: result
end
