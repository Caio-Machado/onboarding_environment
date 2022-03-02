defmodule ApiProducts.ProductsService do
  require ApiProductsWeb

  alias ApiProducts.Management
  alias ApiProducts.RedisService
  alias ApiProducts.ElasticService

  def list(params) do
    with {:ok, nil} <- ElasticService.filter_search(params) do
      result = format_struct(Management.list_products())

      {:ok, result}
    end
  end

  def create(product_params) do
    with {:ok, product} <- Management.create_product(product_params) do
      RedisService.set_product(product)
      ElasticService.add_product(product)
      {:ok, product}
    end
  end

  def show(nil), do: {:error, :not_found}

  def show(%ApiProducts.Management.Products{} = product), do: {:ok, product}

  def update(nil, _), do: {:error, :not_found}

  def update(%ApiProducts.Management.Products{} = product, product_params) do
    with {:ok, result} <- Management.update_product(product, product_params) do
      RedisService.set_product(result)
      ElasticService.add_product(result)
      {:ok, result}
    end
  end

  def delete(nil), do: {:error, :not_found}

  def delete(%ApiProducts.Management.Products{} = product) do
    with {:ok, result} <- Management.delete_product(product) do
      RedisService.delete_product(product.id)
      ElasticService.delete_product(product.id)
      {:ok, result}
    end
  end

  defp format_struct(products) do
    products
    |> Enum.map(fn p -> Map.from_struct(p) end)
    |> Enum.map(fn p -> Map.delete(p, :__meta__) end)
  end
end
