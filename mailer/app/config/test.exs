use Mix.Config

config :mailer, MailerWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
