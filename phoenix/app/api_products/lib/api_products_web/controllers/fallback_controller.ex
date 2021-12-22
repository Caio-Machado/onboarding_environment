defmodule ApiProductsWeb.FallbackController do
  use ApiProductsWeb, :controller

  alias ApiProductsWeb.LogstashController

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ApiProductsWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
    |> LogstashController.save_log()
  end
end
