defmodule ApiProductsWeb.ReportControllerTest do
  use ApiProducts.DataCase
  use ApiProductsWeb.ConnCase

  alias ApiProducts.Management
  alias ApiProducts.ReportService

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

  describe "update_report/2" do
    test "update the CSV file", %{conn: conn, new_product: new_product} do
      Management.create_product(new_product)
      conn = get(conn, Routes.report_path(conn, :update_report))
      {:ok, result} = File.read(ReportService.get_path())
      Management.delete_all()

      assert result == conn.resp_body
    end
  end

  describe "get_report/2" do
    test "return the CSV file for download", %{conn: conn, new_product: new_product} do
      Management.create_product(new_product)
      conn = get(conn, Routes.report_path(conn, :update_report))
      {:ok, result} = File.read(ReportService.get_path())

      assert result == conn.resp_body
    end
  end
end
