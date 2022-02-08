defmodule ApiProducts.ProductsServiceTest do
  use ApiProducts.DataCase

  import Mock

  alias ApiProducts.ProductsService
  alias ApiProducts.ElasticService
  alias ApiProducts.RedisService

  setup_all do
    list_valid = %{"name" => "Nome-teste"}
    new_valid_params = %{"name" => "produto-atualizado", "amount" => 10, "price" => 19}
    [new_valid_params: new_valid_params, list_valid: list_valid]
  end

  setup do
    {:ok, product} = ProductsService.create(%{id: "11aaaa1111111a111111aa11", sku: "valid", name: "Nome-teste", description: "Descrição Teste", amount: 100, price: 99.5, barcode: "030105092"})
    [product: product]
  end

  describe "list/1" do
    test "With valid parameters and without filters", %{product: product} do
      assert {:ok, [product]} == ProductsService.list(%{})
    end

    test "with filters", %{product: product, list_valid: list_valid} do
      with_mock(ElasticService, [:passthrough], [get: fn(_params) -> {:ok, 200, %{}} end]) do
        assert {:ok, [product]} == ProductsService.list(list_valid)
      end
    end

    test "With invalid filters", %{product: product} do
      assert {:error, :bad_request, "For input string: \"invalid\""} == ProductsService.list(%{"amount" => "invalid"})
    end

    test "Without index" do
      ElasticService.delete_all()
      assert {:error, :internal_server_error} == ElasticService.filter_search(%{"amount" => 5})
    end
  end

  describe "update/2" do
    test "With nonexistent product id" do
      assert ProductsService.update(nil, "idinvalido123") == {:error, :not_found}
    end

    test "With an existing product", %{new_valid_params: new_valid_params, product: product} do
      with_mocks([
        {ElasticService,
         [],
         [add_product: fn(_product) -> {:ok, 201, %{}} end]},
        {RedisService,
         [],
         set_product: fn(_product) -> {:ok, "OK"} end}
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

  # describe "delete/2" do
  #   test "With nonexistent product id", %{product: product} do
  #     assert ProductsService.delete(nil) == {:error, :not_found}
  #   end

  #   test "With an existing product" do
  #     with_mocks([
  #       {ElasticService,
  #        [],
  #        [delete_product: fn(_product) -> {:ok, 201, %{}} end]},
  #       {RedisService,
  #        [],
  #        delete_product: fn(_product) -> {:ok, "OK"} end}
  #     ]) do
  #       ProductsService.delete(product)

  #       assert called(ElasticService.add_product(product))
  #       assert called(RedisService.set_product(product))

  #       ProductsService.show(product)

  #       assert ProductsService.get_product(product) == {:ok, 404, _}
  #     end
  #   end
  # end
end
