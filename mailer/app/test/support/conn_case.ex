defmodule MailerWeb.ConnCase do

  use ExUnit.CaseTemplate

  using do
    quote do
      import Plug.Conn
      import Phoenix.ConnTest
      import MailerWeb.ConnCase

      alias MailerWeb.Router.Helpers, as: Routes

      @endpoint MailerWeb.Endpoint
    end
  end

  setup _tags do
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
