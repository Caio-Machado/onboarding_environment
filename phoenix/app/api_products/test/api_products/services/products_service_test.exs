defmodule ApiProducts.ProductsServiceTest do
  use ApiProducts.DataCase

  import Mock

  alias ApiProducts.ProductsService
  alias ApiProducts.ElasticService
  alias ApiProducts.RedisService
  alias ApiProducts.Management

  setup_all do
    list_valid = %{"name" => "Nome-teste"}

    create_params = %{
      "id" => "11aaaa1111111a111111aa11",
      "sku" => "valid",
      "name" => "Nome-teste",
      "description" => "Descrição Teste",
      "amount" => 100,
      "price" => 99.5,
      "barcode" => "030105092"
    }

    new_valid_params = %{"name" => "produto-atualizado", "amount" => 10, "price" => 19}

    invalid_attrs = %{
      "sku" => "invalid_*",
      "name" => "",
      "description" => "Descrição Teste",
      "amount" => 10,
      "price" => 0,
      "barcode" => "005"
    }

    expected_product = %{
      id: "6216692d77161b03291e1f4c",
      sku: "valid",
      name: "Nome-teste",
      description: "Descrição Teste",
      amount: 100,
      price: 99.5,
      barcode: "030105092"
    }

    [
      new_valid_params: new_valid_params,
      list_valid: list_valid,
      create_params: create_params,
      invalid_attrs: invalid_attrs,
      get_product: expected_product
    ]
  end

  setup do
    {:ok, product} =
      Management.create_product(%{
        id: "6216692d77161b03291e1f4c",
        sku: "valid",
        name: "Nome-teste",
        description: "Descrição Teste",
        amount: 100,
        price: 99.5,
        barcode: "030105092"
      })

    [product: product]
  end

  describe "list/1" do
    test "With valid parameters and without filters", %{get_product: product} do
      assert {:ok, [product]} == ProductsService.list(%{})
    end

    test "with filters", %{get_product: product, list_valid: list_valid} do
      with_mock(ElasticService, [],
        filter_search: fn %{"name" => "Nome-teste"} -> {:ok, [product]} end
      ) do
        assert {:ok, [product]} == ProductsService.list(list_valid)
      end
    end

    test "with invalid filters" do
      with_mock(ElasticService, [],
        filter_search: fn %{"amount" => "invalid"} ->
          {:error, :bad_request, "For input string: \"invalid\""}
        end
      ) do
        assert {:error, :bad_request, "For input string: \"invalid\""} ==
                 ProductsService.list(%{"amount" => "invalid"})
      end
    end
  end

  describe "create/1" do
    test "With valid params", %{create_params: create_params} do
      with_mocks([
        {ElasticService, [], [add_product: fn _product -> {:ok, 201, %{}} end]},
        {RedisService, [], set_product: fn _product -> {:ok, "OK"} end}
      ]) do
        {:ok, result} = ProductsService.create(create_params)

        assert called(ElasticService.add_product(result))
        assert called(RedisService.set_product(result))

        assert result == Management.get_product(result.id)
      end
    end

    test "With invalid params", %{invalid_attrs: invalid_attrs} do
      assert {:error, %Ecto.Changeset{}} = Management.create_product(invalid_attrs)
    end
  end

  describe "update/2" do
    test "With nonexistent product id" do
      assert ProductsService.update(nil, "idinvalido123") == {:error, :not_found}
    end

    test "With an existing product", %{new_valid_params: new_valid_params, product: product} do
      with_mocks([
        {ElasticService, [], [add_product: fn _product -> {:ok, 201, %{}} end]},
        {RedisService, [], set_product: fn _product -> {:ok, "OK"} end}
      ]) do
        {:ok, result} = ProductsService.update(product, new_valid_params)

        assert called(ElasticService.add_product(result))
        assert called(RedisService.set_product(result))

        assert result.name == new_valid_params["name"]
        assert result.price == new_valid_params["price"]
        assert result.amount == new_valid_params["amount"]
      end
    end
  end

  describe "delete/2" do
    test "With nonexistent product id" do
      assert ProductsService.delete(nil) == {:error, :not_found}
    end

    test "With an existing product", %{product: product} do
      with_mocks([
        {ElasticService, [], [delete_product: fn _product -> {:ok, 201, %{}} end]},
        {RedisService, [], delete_product: fn _product -> {:ok, "OK"} end}
      ]) do
        ProductsService.delete(product)

        assert called(ElasticService.delete_product(product.id))
        assert called(RedisService.delete_product(product.id))

        assert Management.get_product(product.id) == nil
      end
    end
  end
end
