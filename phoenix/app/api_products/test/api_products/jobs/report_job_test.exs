defmodule ApiProducts.ReportJobTest do
  use ApiProducts.DataCase

  alias ApiProducts.ReportJob
  alias ApiProducts.Management
  alias ApiProducts.ReportService
  alias ApiProducts.ProductsService

  setup_all do
    new_product = %{
      "sku" => "Sku",
      "name" => "Name",
      "description" => "Description",
      "amount" => 50,
      "price" => 10,
      "barcode" => "123456789"
    }

    [new_product: new_product]
  end

  describe "perform/1" do
    test "Write a product to the file", %{new_product: new_product} do
      Management.create_product(new_product)
      {:ok, products} = ProductsService.list(%{})
      ReportJob.perform(%{"report" => "report"})
      {:ok, content} = File.read(ReportService.get_path())
      Management.delete_all()

      result = Enum.join(ReportService.generate_csv(products))

      assert result == content
    end
  end
end
