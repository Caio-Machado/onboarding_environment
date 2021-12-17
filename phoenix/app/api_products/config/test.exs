use Mix.Config

config :api_products, ApiProducts.Repo,
  database: "myapp_development#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :api_products, ApiProductsWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
