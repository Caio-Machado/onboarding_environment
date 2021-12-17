defmodule ApiProductsWeb.ChangesetView do
  use ApiProductsWeb, :view

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("error.json", %{changeset: changeset}) do
    %{error: translate_errors(changeset)}
  end
end
