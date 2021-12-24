defmodule ApiProductsWeb.ProductsService do
  use ApiProductsWeb, :controller

  alias ApiProducts.Management
  alias ApiProductsWeb.RedisService
  alias ApiProductsWeb.ElasticSearchService

  def confirm_index() do
    case RedisService.set_products(Management.list_products()) do
      {:ok, _} -> {:ok, result} = RedisService.get_products()

      {:error, _} -> {:ok, Management.list_products()}
    end
  end

  def confirm_create(product_params) do
    case Management.create_product(product_params) do
      {:ok, result} -> {:ok, result}

      error -> error
    end
  end

  def confirm_update(product, product_params) do
    case Management.update_product(product, product_params) do
      {:ok, _} -> {:ok}

      error -> error
    end
  end

  def confirm_delete(product) do
    case Management.delete_product(product) do
      {:ok, _} -> {:ok}

      error -> error
    end
  end
end
