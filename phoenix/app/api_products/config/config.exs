use Mix.Config

config :api_products,
  ecto_repos: [ApiProducts.Repo]

config :api_products, ApiProductsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+eH8hZnVIVGAac748xrqa1AkfBrgVdpDzPCFy3loo9hS1vTEmO7VVFiDsdVJKkyg",
  render_errors: [view: ApiProductsWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ApiProducts.PubSub,
  live_view: [signing_salt: "662xzens"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id, :trace_id, :span_id]

config :api_products, Repo,
  adapter: Mongo.Ecto,
  database: "myapp_development",
  hostname: "localhost"

config :task_bunny,
  hosts: [
    default: [connect_options: "amqp://localhost?heartbeat=30"]
  ]

config :task_bunny,
  queue: [
    namespace: "task_bunny",
    queues: [[name: "reports", jobs: :default]]
  ]

config :phoenix, :json_library, Jason

config :logger,
  backends: [:console, Sentry.LoggerBackend]

config :api_products, ApiProducts.Tracer,
  service: :api_products,
  adapter: SpandexDatadog.Adapter,
  type: :web,
  env: "dev"

  # config :spandex, :decorators, tracer: ApiProducts.Tracer
  config :spandex_phoenix, tracer: ApiProducts.Tracer

# config :spandex_ecto, SpandexEcto.EctoLogger,
#   service: :api_products_ecto,
#   tracer: PhoenixBackend.Tracer,
#   otp_app: :api_products

import_config "#{Mix.env()}.exs"
