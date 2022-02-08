defmodule ApiProducts.ManagementTest do
  use ApiProducts.DataCase

  alias ApiProducts.Management

  @valid_attrs %{"sku" => "Sku-Teste", "name" => "Nome teste", "description" => "Descrição Teste", "amount" => 100, "price" => 99.5, "barcode" => "030105092"}
  @new_valid_attrs %{"sku" => "Sku-Atualizado", "name" => "Name-Atualizado", "amount" => 50}
  @invalid_attrs %{"sku" => "invalid_*", "name" => "", "description" => "Descrição Teste", "amount" => 10, "price" => 0, "barcode" => "005"}

  @invalid_sku {:error, {"has invalid format", [validation: :format]}}
  @invalid_name {:error, {"can't be blank", [validation: :required]}}
  @invalid_price {:error, {"must be greater than %{number}", [validation: :number, kind: :greater_than, number: 0]}}
  @invalid_barcode {:error, {"should be at least %{count} character(s)", [count: 8, validation: :length, kind: :min, type: :string]}}

  def create_product_test() do
    {:ok, product} = Management.create_product(@valid_attrs)
    product
  end

  describe "get/list products" do
    test "list_products/0 with stored products" do
      product = create_product_test()
      assert [product] == Management.list_products()
    end

    test "list_products/0 with no stored products" do
      assert [] == Management.list_products()
    end

    test "get_product/1 with valid id" do
      product = create_product_test()
      assert product == Management.get_product(product.id)
    end

    test "get_product/1 with invalid id" do
      assert nil == Management.get_product("00aaaa0000000a000000aa00")
    end
  end

  describe "create product" do
    test "create_product/1 with valid attrs" do
      {:ok, result} = Management.create_product(@valid_attrs)
      assert {:ok, Management.get_product(result.id)} == {:ok, result}
    end

    test "create_product/1 with any incorret attrs" do
      assert {:error, %Ecto.Changeset{}} = Management.create_product(@invalid_attrs)
    end

    test "create_product/1 with a non-alphanumeric sku, blank name, price lower than 0, barcode with less than 8 characters" do
      {_error, result} = Management.create_product(@invalid_attrs)
      assert @invalid_sku == {:error, result.errors[:sku]}
      assert @invalid_name == {:error, result.errors[:name]}
      assert @invalid_price == {:error, result.errors[:price]}
      assert @invalid_barcode == {:error, result.errors[:barcode]}
    end
  end

  describe "update product" do
    test "update_product/2 with valid attrs" do
      {:ok, update} = Management.update_product(create_product_test(), @new_valid_attrs)
      assert Management.get_product(update.id) == update
    end

    test "update_product/2 with invalid attrs" do
      {:error, result} = Management.update_product(create_product_test(), @invalid_attrs)
      assert @invalid_sku == {:error, result.errors[:sku]}
      assert @invalid_name == {:error, result.errors[:name]}
      assert @invalid_price == {:error, result.errors[:price]}
      assert @invalid_barcode == {:error, result.errors[:barcode]}
    end
  end

  describe "delete product" do
    test "delete_product/2 with valid id" do
      {:ok, deleted_product} = Management.delete_product(create_product_test())
      assert Management.get_product(deleted_product.id) == nil
    end
  end
end
