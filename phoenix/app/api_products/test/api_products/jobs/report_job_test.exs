defmodule ApiProducts.ReportJobTest do
  use ApiProducts.DataCase

  import Mock

  alias ApiProducts.ReportJob
  alias ApiProducts.Management
  alias ApiProducts.ReportService
  alias ApiProducts.ProductsService

  setup_all do
    expected_report =
      "amount,barcode,description,id,name,price,sku\r\n50,123456789,Description,6216692d77161b03291e1f4c,Name,10.0,Sku\r\n"

    [expected_report: expected_report]
  end

  setup do
    Management.create_product(%{
      "id" => "6216692d77161b03291e1f4c",
      "sku" => "Sku",
      "name" => "Name",
      "description" => "Description",
      "amount" => 50,
      "price" => 10,
      "barcode" => "123456789"
    })

    :ok
  end

  describe "perform/1" do
    test "with a product stored", %{expected_report: expected_report} do
      ReportJob.perform(%{"type" => "products"})
      {:ok, content} = File.read(ReportService.get_path())

      assert expected_report == content
    end

    test "with no product stored" do
      with_mock(ProductsService, [], list: fn %{} -> {:ok, []} end) do
        ReportJob.perform(%{"type" => "products"})
        {:ok, content} = File.read(ReportService.get_path())

        assert "" == content
      end
    end
  end
end
