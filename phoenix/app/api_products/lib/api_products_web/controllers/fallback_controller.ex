defmodule ApiProductsWeb.FallbackController do
  use ApiProductsWeb, :controller

  alias ApiProductsWeb.ElasticSearchService

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ApiProductsWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
    |> ElasticSearchService.save_log()
  end

  def call(conn, {:error, %Redix.ConnectionError{} = error}) do
    conn
    |> put_status(:service_unavailable)
    |> put_view(ApiProductsWeb.ErrorView)
    |> render(:"503")
    |> halt()
    |> ElasticSearchService.save_log()
  end
end
