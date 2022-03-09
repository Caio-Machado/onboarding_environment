defmodule MailerWeb.MailerController do
  use MailerWeb, :controller

  alias Mailer.Mailer
  alias MailerWeb.MailerService

  def send(conn, _) do
    Mailer.deliver_later(MailerService.create_email())
    send_resp(conn, 202, "")
  end
end
