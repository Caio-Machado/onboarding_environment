defmodule ApiProducts.ProductsServiceTest do
  use ApiProducts.DataCase

  alias ApiProducts.ProductsService

  @list_valid %{"name" => "produto", "amount" => 10, "c_amount" => "gt"}
  @create_invalid_params %{"sku" => "Sku_Teste-1", "name" => "Nome-teste", "description" => "Descrição Teste 1", "amount" => 1, "price" => 0, "bar_code" => "12345"}
  @create_valid_params %{"sku" => "Sku-Teste-1", "name" => "Nome teste", "description" => "Descrição Teste 1", "amount" => 1, "price" => 9, "bar_code" => "123356789"}
  @create_blank_params %{"sku" => "Sku-Teste-1", "name" => "", "description" => "   ", "amount" => 1, "price" => 9, "bar_code" => "123356789"}

  test "list/1 with the valid parameters" do
    assert {:ok, []} = ProductsService.list(@list_valid)
  end

  test "create/1 with invalid sku, price and bar_code paramters" do
    assert {:error, :bad_request, _menssage} = ProductsService.create(@create_invalid_params)
  end

  test "create/1 with valid paramters" do
    assert {:ok, %{}} = ProductsService.create(@create_valid_params)
  end

  test "create/1 with name, description parameters blank" do
    assert {:error, _error} = ProductsService.create(@create_blank_params)
  end

  test "update/2 with nonexistent product id" do
    assert ProductsService.update(nil, "idinvalido123") == {:error, :not_found}
  end

  test "delete/2 with nonexistent product id" do
    assert ProductsService.delete(nil) == {:error, :not_found}
  end
end
