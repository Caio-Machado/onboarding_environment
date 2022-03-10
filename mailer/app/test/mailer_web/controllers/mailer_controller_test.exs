defmodule MailerWeb.MailerControllerTest do
  use MailerWeb.ConnCase

  import Mock

  alias MailerWeb.MailerController
  alias MailerWeb.Router.Helpers, as: Routes
  alias Mailer.Mailer

  describe "send/2" do
    test "with the email sent", %{conn: conn} do
      with_mock(Mailer, [], deliver_later: fn(_) -> {:ok, %Bamboo.Email{}} end) do
        conn = get(conn, Routes.mailer_path(conn, :send))
        # assert
      end
    end
  end
end
