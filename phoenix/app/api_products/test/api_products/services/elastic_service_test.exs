defmodule ApiProducts.ElasticServiceTest do
  use ApiProducts.DataCase

  alias ApiProducts.ElasticService
  alias ApiProducts.Management

  setup_all do
    valid_filters = %{"name" => "Nome-teste"}
    [valid_filters: valid_filters]
  end

  setup do
    ElasticService.add_product(%{id: "11aaaa1111111a111111aa11", sku: "valid", name: "Nome-teste", description: "Descrição Teste", amount: 100, price: 99.5, barcode: "030105092"})
    {:ok, 200, product} = ElasticService.get_product("11aaaa1111111a111111aa11")
    [product: product[:_source]]
  end

  describe "add_product/1" do
    test "With valid product", %{product: product} do
      {:ok, 200, result} = ElasticService.get_product(product.id)
      assert product.id == result[:_source][:id]
    end
  end

  describe "get_product/1" do
    test "With valid id", %{product: product} do
      {:ok, 200, result} = ElasticService.get_product(product.id)
      assert product.id == result[:_source][:id]
    end

    test "With invalid id", %{product: product} do
      {:error, 404, %{}} = ElasticService.get_product("00aaaa0000000a000000aa00")
    end
  end

  describe "delete_product/1" do
    test "With valid id", %{product: product} do
      ElasticService.delete_product(product.id)
      assert {:error, 404, %{}} = ElasticService.get_product(product.id)
    end

    test "With invalid id", %{product: product} do
      assert {:error, 404, %{}} = ElasticService.delete_product("00aaaa0000000a000000aa00")
    end
  end

  describe "filter_search/1" do
    test "With empty parameters", %{product: product} do
      assert {:ok, nil} == ElasticService.filter_search(%{})
    end

    test "With valid parameters", %{valid_filters: valid_filters} do
      ElasticService.filter_search(valid_filters)
    end
  end
end
