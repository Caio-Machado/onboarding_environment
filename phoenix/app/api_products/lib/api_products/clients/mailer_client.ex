defmodule ApiProducts.MailerClient do
  def send_report() do
    HTTPoison.post(get_url(), "")
  end

  defp get_url(), do: Application.get_env(:api_products, :mailer_url)
end
