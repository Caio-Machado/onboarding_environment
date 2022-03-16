defmodule ApiProducts.ReportJobTest do
  use ApiProducts.DataCase
  use HTTPoison.Base

  import Mock

  alias ApiProducts.ReportJob
  alias ApiProducts.Management
  alias ApiProducts.Fixtures
  alias ApiProducts.ReportService
  alias ApiProducts.ProductsService
  alias ApiProducts.MailerClient

  setup_all do
    expected_report = Fixtures.get_fixture(:expected_report)
    mailer_url = Application.get_env(:api_products, :mailer_url)

    [expected_report: expected_report, mailer_url: mailer_url]
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
      with_mock(MailerClient, [], send_report: fn -> {:ok, %HTTPoison.Response{}} end) do
        ReportJob.perform(%{"type" => "products"})
        {:ok, content} = File.read(ReportService.get_path())

        assert_called(MailerClient.send_report())
        assert expected_report == content
      end
    end

    test "with no product stored" do
      with_mocks([
        {ProductsService, [], list: fn %{} -> {:ok, []} end},
        {MailerClient, [], send_report: fn -> {:ok, %HTTPoison.Response{}} end}
      ]) do
        ReportJob.perform(%{"type" => "products"})
        {:ok, content} = File.read(ReportService.get_path())

        assert_called(MailerClient.send_report())
        assert "" == content
      end
    end
  end
end
