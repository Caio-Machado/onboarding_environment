defmodule ApiProducts.ElasticServiceTest do
  use ApiProducts.DataCase

  alias ApiProducts.ElasticService

  @filter_search_valid %{"name" => "product", "amount" => 10, "c_amount" => "lt"}
  @filter_search_invalid %{"name" => "product", "amount" => ""}

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
