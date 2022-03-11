defmodule MailerWeb.MailerService do
  import Bamboo.Email

  def create_email() do
    new_email()
      |> to("testemail1@email.com")
      |> from("testemail2@email.com")
      |> subject("Products Report")
      |> put_attachment(Application.get_env(:mailer, :report)[:path])
  end
end
