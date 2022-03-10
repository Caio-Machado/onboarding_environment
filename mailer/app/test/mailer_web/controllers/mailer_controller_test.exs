defmodule MailerWeb.MailerControllerTest do
  use MailerWeb.ConnCase
  use Bamboo.Test

  import Mock

  alias MailerWeb.MailerController
  alias MailerWeb.Router.Helpers, as: Routes
  alias Mailer.Mailer

  describe "send/2" do
    test "with the email sent", %{conn: conn} do
      conn = post(conn, Routes.mailer_path(conn, :send))
      # assert
    end
  end
end
