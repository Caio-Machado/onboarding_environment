defmodule ApiProducts.ReportJob do
  alias ApiProducts.ReportService
  alias ApiProducts.ProductsService

  use TaskBunny.Job
  require Logger

  def perform(%{"report" => "report"}) do
    {:ok, products} = ProductsService.list(%{})
    encoded = ReportService.generate_csv(products)
    File.write(ReportService.get_path(), encoded)
    :ok
  end
end
