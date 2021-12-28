defmodule ApiProductsWeb.FallbackController do
  use ApiProductsWeb, :controller

  plug(ApiProductsWeb.SaveLogPlug)

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ApiProductsWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ApiProductsWeb.ErrorView)
    |> render(:"404")
    |> halt()
  end
end
