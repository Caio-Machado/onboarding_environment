use Mix.Config

config :mailer, MailerWeb.Endpoint,
  http: [port: 4001],
  debug_errors: true,
  code_reloader: true,
  check_origin: false

config :logger, :console, format: "[$level] $message\n"

config :sentry,
  dsn: "http://98a9c6ef9c5148fcb9ccf4f808e54d1b@127.0.0.1:9000/2",
  environment_name: :dev,
  enable_source_code_context: true,
  root_source_code_path: File.cwd!(),
  included_environments: [:dev]

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime

config :mailer, :report, path: "/tmp/report.csv"
