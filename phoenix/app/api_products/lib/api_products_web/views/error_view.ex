defmodule ApiProductsWeb.ErrorView do
  use ApiProductsWeb, :view

  def template_not_found(template, assigns) do
    if assigns == "" do
      %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
    else
      %{errors: %{detail: assigns.menssage}}
    end
  end
end
