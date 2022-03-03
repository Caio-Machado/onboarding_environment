defmodule Test.ProductsReport do
  def get_fixture(fixture) do
    fixture
    |> do_get_fixture()
    |> File.read()
  end

  defp do_get_fixture(:expected_report), do: "/app/api_products/test/api_products/files/base_files/base_report_test.csv"
end
