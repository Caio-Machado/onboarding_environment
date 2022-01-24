defmodule ApiProductsWeb.ConnCase do

  use ExUnit.CaseTemplate

  using do
    quote do
      import Plug.Conn
      import Phoenix.ConnTest
      import ApiProductsWeb.ConnCase

      alias ApiProductsWeb.Router.Helpers, as: Routes

      @endpoint ApiProductsWeb.Endpoint
    end
  end

  setup tags do
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
