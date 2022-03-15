defmodule ApiProducts.ReportJob do
  use TaskBunny.Job
  use HTTPoison.Base

  alias ApiProducts.ReportService
  alias ApiProducts.ProductsService

  def perform(%{"type" => "products"}) do
    {:ok, products} = ProductsService.list(%{})
    encoded = ReportService.generate_csv(products)
    HTTPoison.post(Application.get_env(:api_products, :mailer_url), "")
    File.write(ReportService.get_path(), encoded)
  end
end
