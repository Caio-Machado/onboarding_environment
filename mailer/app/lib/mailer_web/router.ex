defmodule MailerWeb.Router do
  use Phoenix.Router
  use Spandex.Decorators

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MailerWeb do
    pipe_through(:api)

    post "/mailer", MailerController, :send
  end

  if Mix.env() == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end
end
