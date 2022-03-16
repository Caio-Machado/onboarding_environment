defmodule MailerWeb.ChannelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Phoenix.ChannelTest
      import MailerWeb.ChannelCase

      @endpoint MailerWeb.Endpoint
    end
  end

  setup _tags do
    :ok
  end
end
