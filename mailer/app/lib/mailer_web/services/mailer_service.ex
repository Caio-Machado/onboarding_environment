defmodule MailerWeb.MailerService do
  import Bamboo.Email

  alias Mailer.Mailer

  def send_email(%Bamboo.Email{} = email), do: Mailer.deliver_later(email)

  def send_email(:file_not_found), do: {:error, "File report.csv not found"}

  def create_email() do
    if File.exists?(Application.get_env(:mailer, :report)[:path]) do
      new_email()
      |> to("testemail1@email.com")
      |> from("testemail2@email.com")
      |> subject("Products report updated")
      |> put_attachment(report_path())
    else
      :file_not_found
    end
  end

  defp report_path(), do: Application.get_env(:mailer, :report)[:path]
end
