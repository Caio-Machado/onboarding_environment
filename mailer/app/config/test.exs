use Mix.Config

config :mailer, MailerWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn

config :mailer, Mailer.Mailer,
  adapter: Bamboo.TestAdapter

config :mailer, :report, path: "/app/test/mailer_web/fixture/report_fix.csv"
