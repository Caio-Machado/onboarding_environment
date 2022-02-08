defmodule ApiProducts.RedisServiceTest do
  use ApiProducts.DataCase

  alias ApiProducts.RedisService

  import Mock

  @valid_product %{id: "61e032e177161c002dbf8aef", sku: "Sku test", name: "Name test", description: "Description test", amount: 100, price: 50.0}

  test "get_product/1 stores a product in the redis" do
    with_mock RedisService, [get_product: fn(_product) -> {:ok, nil} end] do
      assert {:ok, nil} == RedisService.get_product("idinvalido")
    end
  end

  test "get_product/1 stores a product in the redi" do
    with_mock RedisService, [get_product: fn(_id) -> {:ok, %{}} end] do
      assert {:ok, %{}} = RedisService.get_product(@valid_product.id)
    end
  end

  test "delete_product/1 with valid param" do
    with_mock RedisService, [delete_product: fn(_id) -> {:ok, 1} end] do
      assert {:ok, 1} = RedisService.delete_product(@valid_product.id)
    end
  end

  test "delete_product/1 with invalid param" do
    with_mock RedisService, [delete_product: fn(_id) -> {:ok, 0} end] do
      assert {:ok, 0} == RedisService.delete_product("idinvalido")
    end
  end
end
