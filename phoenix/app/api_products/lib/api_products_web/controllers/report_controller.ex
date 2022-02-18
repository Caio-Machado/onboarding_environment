defmodule ApiProductsWeb.ReportController do
  use ApiProductsWeb, :controller

  alias ApiProducts.ReportService
  alias ApiProductsWeb.ReportJob

  def get_report(conn, _) do
    send_download(conn, {:file, ReportService.get_path()})
  end

  def update_report(conn, _) do
    ReportJob.enqueue(%{"report" => "report"})
    send_resp(conn, 204, "")
  end
end
