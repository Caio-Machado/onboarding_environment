defmodule ApiProducts.ReportServiceTest do
  use ApiProducts.DataCase

  alias ApiProducts.ReportService

  setup_all do
    product = [
      %{
        "id" => "11aaaa1111111a111111aa11",
        "sku" => "valid",
        "name" => "Nome-teste",
        "description" => "Descrição Teste",
        "amount" => 100,
        "price" => 99.5,
        "barcode" => "030105092"
      }
    ]

    generated_csv = [
      "amount,barcode,description,id,name,price,sku\r\n",
      "100,030105092,Descrição Teste,11aaaa1111111a111111aa11,Nome-teste,99.5,valid\r\n"
    ]

    [product: product, generated_csv: generated_csv]
  end

  test "generate_csv/1", %{product: product, generated_csv: generated_csv} do
    assert ReportService.generate_csv(product) == generated_csv
  end
end
