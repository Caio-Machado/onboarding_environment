use Mix.Config

config :mailer, MailerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3q2QhWk9NwYvjnLqEYIcmhLPT5dL0iNknLUiXoXV0+LmQP4Z6cWRbz5IELH1/AhL",
  render_errors: [view: MailerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Mailer.PubSub,
  live_view: [signing_salt: "oXrwkIn5"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :mailer, Mailer.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.mailtrap.io",
  hostname: "smtp.mailtrap.io",
  port: 2525,
  username: "9d275b5f7f8128",
  password: "32436c1e4f39d6",
  tls: :always,
  allowed_tls_versions: [:"tlsv1", :"tlsv1.1", :"tlsv1.2"],
  ssl: false,
  retries: 1,
  no_mx_lookups: false,
  auth: :if_available

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
