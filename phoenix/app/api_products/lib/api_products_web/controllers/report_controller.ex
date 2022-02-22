defmodule ApiProductsWeb.ReportController do
  use ApiProductsWeb, :controller

  alias ApiProducts.ReportService
  alias ApiProducts.ReportJob

  def get_report(conn, _) do
    send_download(conn, {:file, ReportService.get_path()})
  end

  def update_report(conn, _) do
    case ReportJob.enqueue(%{"report" => "report"}) do
      :ok -> send_resp(conn, 204, "")

      error -> send_resp(conn, 500, "")
    end
  end
end
