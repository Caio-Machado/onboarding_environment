use Mix.Config

config :mailer, MailerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3q2QhWk9NwYvjnLqEYIcmhLPT5dL0iNknLUiXoXV0+LmQP4Z6cWRbz5IELH1/AhL",
  render_errors: [view: MailerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Mailer.PubSub,
  live_view: [signing_salt: "oXrwkIn5"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id, :trace_id, :span_id]

config :mailer, Mailer.Mailer, adapter: Bamboo.LocalAdapter

config :phoenix, :json_library, Jason

config :mailer, Mailer.Tracer,
  service: :mailer,
  adapter: SpandexDatadog.Adapter,
  disabled?: false,
  env: "dev"

config :mailer, SpandexDatadog.ApiServer,
  host: "http://127.0.0.1",
  port: 8126,
  batchsize: 10,
  sync_trasholder: 100,
  http: HTTPoison

config :spandex, :decorators, tracer: Mailer.Tracer
config :spandex_phoenix, tracer: Mailer.Tracer

config :spandex_ecto, SpandexEcto.EctoLogger,
  service: :mailer_ecto,
  tracer: PhoenixBackend.Tracer,
  otp_app: :mailer

import_config "#{Mix.env()}.exs"
