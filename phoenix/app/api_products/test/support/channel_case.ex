defmodule ApiProductsWeb.ChannelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Phoenix.ChannelTest
      import ApiProductsWeb.ChannelCase

      @endpoint ApiProductsWeb.Endpoint
    end
  end
end
