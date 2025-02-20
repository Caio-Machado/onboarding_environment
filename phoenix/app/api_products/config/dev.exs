use Mix.Config

config :api_products, ApiProducts.Repo,
  database: "myapp_development",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :api_products, ApiProductsWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime

config :tirexs, :uri, "http://127.0.0.1:9200"

config :api_products, :mailer_url, "http://127.0.0.1:4001/mailer"

config :api_products, redis_server: 0

config :api_products, :elsc_prod, link: "products/"
config :api_products, :elsc_prod, index: "product/"
config :api_products, :elsc_logs, link: "logs/"
config :api_products, :elsc_logs, index: "requests/"

config :api_products, :report, path: "/tmp/report.csv"
