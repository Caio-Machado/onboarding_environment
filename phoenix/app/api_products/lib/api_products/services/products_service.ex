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
    case Management.create_product(product_params) do
      {:ok, result} ->
        RedisService.delete_products()
        {:ok, result}

      error -> error
    end
  end

  def show(product) do
    case product do
      nil -> {:error, :not_found}

      %ApiProducts.Management.Products{} -> {:ok, product}
    end
  end

  def update(product, product_params) do
    case product do
      nil -> {:error, :not_found}

      %ApiProducts.Management.Products{} ->
        case Management.update_product(product, product_params) do
          {:ok, _} -> RedisService.delete_products()

          error -> error
        end
    end
  end

  def delete(product) do
    case product do
      nil -> {:error, :not_found}

      %ApiProducts.Management.Products{} ->
        case Management.delete_product(product) do
          {:ok, _} -> RedisService.delete_products()

          error -> error
        end
    end
  end
end
