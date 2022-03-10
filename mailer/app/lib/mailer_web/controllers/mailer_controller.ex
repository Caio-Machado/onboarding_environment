defmodule MailerWeb.MailerController do
  use MailerWeb, :controller

  alias Mailer.Mailer
  alias MailerWeb.MailerService

  def send(conn, _) do
    case Mailer.deliver_later(MailerService.create_email()) do
      {:ok, %Bamboo.Email{}} -> send_resp(conn, 202, "")
      {:error, _} -> send_resp(conn, 500, "")
    end
  end
end
