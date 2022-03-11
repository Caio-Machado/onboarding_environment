defmodule MailerWeb.MailerControllerTest do
  use MailerWeb.ConnCase
  use Bamboo.Test

  alias MailerWeb.Router.Helpers, as: Routes

  describe "send/2" do
    test "with the email sent", %{conn: conn} do
      conn = post(build_conn(), Routes.mailer_path(conn, :send))

      assert_email_delivered_with([subject: "Products Report"])
    end
  end
end
