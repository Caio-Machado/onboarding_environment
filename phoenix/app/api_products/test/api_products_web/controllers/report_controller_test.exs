defmodule ApiProductsWeb.ReportControllerTest do
  use ApiProducts.DataCase
  use ApiProductsWeb.ConnCase

  import Mock

  alias ApiProducts.Management
  alias ApiProducts.ReportJob
  alias Test.ApiProducts.ProductsReport

  setup_all do
    {:ok, expected_report} = ProductsReport.get_fixture(:expected_report)

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

    ReportJob.perform(%{"type" => "products"})

    :ok
  end

  describe "update_report/2" do
    test "enqueues the report", %{conn: conn} do
      with_mock(ReportJob, [], enqueue: fn %{"type" => "products"} -> :ok end) do
        post(conn, Routes.report_path(conn, :update_report))

        assert_called(ReportJob.enqueue(%{"type" => "products"}))
      end
    end
  end

  describe "get_report/2" do
    test "return the CSV file for download", %{conn: conn, expected_report: expected_report} do
      conn = get(conn, Routes.report_path(conn, :update_report))

      assert conn.resp_body == expected_report
    end
  end
end
