defmodule ApiProducts.Fixtures do
  def get_fixture(fixture) do
    {:ok, content} =
      fixture
      |> do_get_fixture()
      |> File.read()

    content
  end

  defp do_get_fixture(:expected_report),
    do: "/app/api_products/test/api_products/fixtures/base_report_test.csv"
end
