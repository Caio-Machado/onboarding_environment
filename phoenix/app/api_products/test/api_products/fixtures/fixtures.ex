defmodule ApiProducts.Fixtures do
  def get_fixture(fixture) do
    fixture
    |> do_get_fixture()
    |> File.read()
  end

  defp do_get_fixture(:expected_report), do: "/app/api_products/test/api_products/fixtures/base_report_test.csv"
end
