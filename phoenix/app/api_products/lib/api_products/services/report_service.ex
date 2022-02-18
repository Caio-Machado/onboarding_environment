defmodule ApiProducts.ReportService do

  def generate_csv(content) do
    content
    |> CSV.Encoding.Encoder.encode(headers: true)
    |> Enum.to_list()
  end

  def get_path(), do: "/app/api_products/lib/api_products/files/report.csv"
end
