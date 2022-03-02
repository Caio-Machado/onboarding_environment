defmodule ApiProducts.ReportJob do
  alias ApiProducts.ReportService
  alias ApiProducts.ProductsService

  use TaskBunny.Job

  def perform(%{"type" => "products"}) do
    {:ok, products} = ProductsService.list(%{})
    encoded = ReportService.generate_csv(products)
    File.write(ReportService.get_path(), encoded)
  end
end
