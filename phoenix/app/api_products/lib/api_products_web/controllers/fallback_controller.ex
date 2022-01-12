defmodule ApiProductsWeb.FallbackController do
  use ApiProductsWeb, :controller

  plug(ApiProducts.SaveLogPlug)

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ApiProductsWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(404)
    |> put_view(ApiProductsWeb.ErrorView)
    |> render(:"404")
    |> halt()
  end

  def call(conn, {:error, :internal_server_error}) do
    conn
    |> put_status(500)
    |> put_view(ApiProductsWeb.ErrorView)
    |> render(:"500")
    |> halt()
  end
end
