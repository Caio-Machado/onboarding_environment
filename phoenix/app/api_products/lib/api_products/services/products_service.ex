defmodule ApiProducts.ProductsService do
  require ApiProductsWeb

  alias ApiProducts.Management
  alias ApiProducts.RedisService
  alias ApiProducts.ElasticService

  def list(params) do
    with {:ok, nil} <- ElasticService.filter_search(params) do
      {:ok, Management.list_products()}
    end
  end

  def create(product_params) do
    with {:ok, true} <- validate_parameters(product_params),
         {:ok, product} <- Management.create_product(product_params) do
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

  defp validate_parameters(params) do
    confirm_param({:ok, true}, "sku", params["sku"])
    |> confirm_param("price", params["price"])
    |> confirm_param("bar_code", params["bar_code"])
  end

  defp confirm_param({:error, :bad_request, menssage}, _, _), do: {:error, :bad_request, menssage}

  defp confirm_param({:ok, _true}, "sku", value) do
    if String.match?(value, ~r/^([a-zA-Z0-9]|-)+$/) do
      {:ok, true}
    else
      {:error, :bad_request, "sku can be only alphanumeric"}
    end
  end

  defp confirm_param({:ok, _true}, "price", value) do
    if value > 0 do
      {:ok, true}
    else
      {:error, :bad_request, "the price must be greater than 0"}
    end
  end

  defp confirm_param({:ok, _true}, "bar_code", value) do
    if String.length(value) >= 8 && String.length(value) <= 10 do
      {:ok, true}
    else
      {:error, :bad_request, "bar_code must be 8-10 digits"}
    end
  end
end
