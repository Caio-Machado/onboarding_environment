defmodule ApiProducts.ReportServiceTest do
  use ApiProducts.DataCase

  alias ApiProducts.ReportService

  setup_all do
    product = [
      %{
        "id" => "6216692d77161b03291e1f4c",
        "sku" => "Sku",
        "name" => "Name",
        "description" => "Description",
        "amount" => 50,
        "price" => 10,
        "barcode" => "123456789"
      }
    ]

    generated_csv = [
      "amount,barcode,description,id,name,price,sku\r\n",
      "50,123456789,Description,6216692d77161b03291e1f4c,Name,10,Sku\r\n"
    ]

    [product: product, generated_csv: generated_csv]
  end

  describe "generate_csv/1" do
    test "with a list with products", %{product: product, generated_csv: generated_csv} do
      assert ReportService.generate_csv(product) == generated_csv
    end

    test "with a empty list paramter" do
      assert ReportService.generate_csv([]) == []
    end

    test "with a nil paramter" do
      assert ReportService.generate_csv(nil) == []
    end
  end
end
