defmodule Mailer.Application do
  use Application

  import Supervisor.Spec

  def start(_type, _args) do
    spandex_opts = [
      host: "http://127.0.0.1",
      port: 8126,
      batch_size: 10,
      sync_threshold: 100,
      http: HTTPoison
    ]

    Logger.add_backend(Sentry.LoggerBackend)

    children = [
      {SpandexDatadog.ApiServer, spandex_opts},
      MailerWeb.Telemetry,
      {Phoenix.PubSub, name: Mailer.PubSub},
      MailerWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Mailer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    MailerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
