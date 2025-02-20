defmodule ApiProducts.ReportService do
  def generate_csv(nil), do: []

  def generate_csv(content) do
    content
    |> CSV.Encoding.Encoder.encode(headers: true)
    |> Enum.to_list()
  end

  def get_path(), do: Application.get_env(:api_products, :report)[:path]
end
