defmodule ApiProductsWeb.ErrorHelpers do
  def translate_error({msg, opts}) do
    if count = opts[:count] do
      Gettext.dngettext(ApiProductsWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(ApiProductsWeb.Gettext, "errors", msg, opts)
    end
  end
end
