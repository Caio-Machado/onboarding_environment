defmodule ApiProductsWeb.ErrorView do
  use ApiProductsWeb, :view

  def template_not_found("400.json", assigns) do
    %{errors: %{detail: assigns.menssage}}
  end

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
