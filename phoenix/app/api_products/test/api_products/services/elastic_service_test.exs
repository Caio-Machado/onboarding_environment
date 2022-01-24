defmodule ApiProducts.ElasticServiceTest do
  use ApiProducts.DataCase

  import Mock

  alias ApiProducts.ElasticService
  alias ApiProducts.Management

  @filter_search_valid %{"name" => "product", "amount" => 10, "c_amount" => "lt"}
  @filter_search_invalid %{"name" => "product", "amount" => ""}
  @valid_attrs %{"sku" => "invalid", "name" => "Nome teste", "description" => "Descrição Teste", "amount" => 100, "price" => 99.5, "bar_code" => "030105092"}

  def create_product_test() do
    {:ok, product} = Management.create_product(@valid_attrs)
    product
  end

  test "add_product/1 with valid product" do
    with_mock ElasticService, [add_product: fn(_product) -> {:ok, 201, %{}} end] do
      assert {:ok, 201, _} = ElasticService.add_product(create_product_test())
    end
  end

  test "add_product/1 with valid product for update a product" do
    with_mock ElasticService, [add_product: fn(_product) -> {:ok, 200, %{}} end] do
      assert {:ok, 200, _} = ElasticService.add_product(create_product_test())
    end
  end

  test "delete_product/1 with valid id" do
    with_mock ElasticService, [delete_product: fn(_product) -> {:ok, 200, %{}} end] do
      assert {:ok, 200, _} = ElasticService.delete_product(create_product_test().id)
    end
  end

  test "delete_product/1 with invalid id" do
    with_mock ElasticService, [delete_product: fn(_product) -> {:error, 404, %{}} end] do
      assert {:error, 404, _} = ElasticService.delete_product("InvalidID")
    end
  end

  test "filter_search/1 with empty parameters" do
    assert {:ok, nil} = ElasticService.filter_search(%{})
  end

  test "filter_search/1 with valid parameters" do
    assert {:ok, result} = ElasticService.filter_search(@filter_search_valid)
  end

  test "filter_search/1 with invalid parameters" do
    assert {:error, :bad_request, menssage} = ElasticService.filter_search(@filter_search_invalid)
  end
end
