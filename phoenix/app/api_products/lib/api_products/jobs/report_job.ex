defmodule ApiProducts.ReportJob do
  use TaskBunny.Job

  alias ApiProducts.ReportService
  alias ApiProducts.ProductsService
  alias ApiProducts.MailerClient

  def perform(%{"type" => "products"}) do
    {:ok, products} = ProductsService.list(%{})
    encoded = ReportService.generate_csv(products)

    with :ok <- File.write(ReportService.get_path(), encoded) do
      MailerClient.send_report()
    end
  end
end
