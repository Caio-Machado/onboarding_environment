defmodule MailerWeb.Router do
  use MailerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MailerWeb do
    pipe_through(:api)

    get "/mailer", MailerController, :send
  end
end
