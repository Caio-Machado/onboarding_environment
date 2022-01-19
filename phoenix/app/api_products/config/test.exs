use Mix.Config

config :api_products, ApiProducts.Repo,
  database: "myapp_development_test",
  hostname: "localhost"

config :api_products, ApiProductsWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
