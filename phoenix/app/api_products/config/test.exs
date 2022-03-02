use Mix.Config

config :api_products, ApiProducts.Repo,
  database: "myapp_development_test",
  hostname: "localhost"

config :api_products, ApiProductsWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
config :api_products, redis_server: 1
config :api_products, :elsc_prod, link: "testproducts/"
config :api_products, :elsc_prod, index: "product/"
config :api_products, :elsc_logs, link: "testlogs/"
config :api_products, :elsc_logs, index: "requests/"
config :api_products, :report, path: "/app/api_products/test/api_products/files/test files/report_test.csv"
config :api_products, :base_report, path: "/app/api_products/test/api_products/files/base files/base_report_test.csv"
