defmodule ApiProducts.ManagementTest do
  use ApiProducts.DataCase

  alias ApiProducts.Management

  @valid_attrs %{"sku" => "Sku-Teste", "name" => "Nome teste", "description" => "Descrição Teste", "amount" => 100, "price" => 99.5, "bar_code" => "030105092"}
  @new_valid_attrs %{"sku" => "Sku-Atualizado", "name" => "Name-Atualizado", "amount" => 50}
  @invalid_attrs %{"sku" => "", "name" => nil, "description" => "Descrição Teste", "amount" => 10.5, "price" => 99.5, "bar_code" => "030105092"}

  def create_product_test() do
    {:ok, product} = Management.create_product(@valid_attrs)
    product
  end

  test "list_products/0 with stored products" do
    create_product_test()
    assert [] != Management.list_products()
  end

  test "list_products/0 with no stored products" do
    assert [] == Management.list_products()
  end

  test "get_product/1 with valid id" do
    assert %{} = Management.get_product(create_product_test().id)
  end

  test "get_product/1 with invalid id" do
    assert nil == Management.get_product("00aaaa0000000a000000aa00")
  end

  test "create_product/1 with valid attrs" do
    assert {:ok, %{}} = Management.create_product(@valid_attrs)
  end

  test "create_product/1 with invalid attrs" do
    assert {:error, _} = Management.create_product(@invalid_attrs)
  end

  test "update_product/2 with valid attrs" do
    assert {:ok, %{}} = Management.update_product(create_product_test(), @new_valid_attrs)
  end

  test "update_product/2 with invalid attrs" do
    assert {:error, _} = Management.update_product(create_product_test(), @invalid_attrs)
  end

  test "delete_product/2 with valid id" do
    assert {:ok, %{}} = Management.delete_product(create_product_test())
  end
end
