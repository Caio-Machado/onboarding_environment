defmodule ApiProducts.RedisServiceTest do
  use ApiProducts.DataCase

  import Mock

  alias ApiProducts.RedisService
  alias ApiProducts.Management

  setup do
    {:ok, product} =
      Management.create_product(%{
        "sku" => "Sku-Teste",
        "name" => "Nome teste",
        "description" => "Descrição Teste",
        "amount" => 100,
        "price" => 99.5,
        "barcode" => "030105092"
      })

    RedisService.set_product(product)
    [product: product]
  end

  describe "get_product/1" do
    test "With invalid id" do
      with_mock(RedisService, [], get_product: fn _product_id -> {:ok, nil} end) do
        assert {:ok, nil} == RedisService.get_product("idinvalido")
      end
    end

    test "With valid id", %{product: product} do
      with_mock(RedisService, [], get_product: fn _product_id -> {:ok, product} end) do
        assert {:ok, product} == RedisService.get_product(product.id)
      end
    end
  end

  describe "set_product/1" do
    test "With valid params", %{product: product} do
      with_mocks([
        {RedisService, [], set_product: fn _product -> {:ok, "OK"} end},
        {RedisService, [], get_product: fn _product_id -> {:ok, product} end}
      ]) do
        assert {:ok, "OK"} == RedisService.set_product(product)
        assert {:ok, product} == RedisService.get_product(product.id)
      end
    end
  end

  describe "delete_product/1" do
    test "With valid param", %{product: product} do
      with_mock(RedisService, [], delete_product: fn _product_id -> {:ok, 1} end) do
        assert {:ok, 1} == RedisService.delete_product(product.id)
      end
    end

    test "With invalid param" do
      with_mock(RedisService, [], delete_product: fn _product_id -> {:ok, 0} end) do
        assert {:ok, 0} == RedisService.delete_product("idinvalido")
      end
    end
  end
end
