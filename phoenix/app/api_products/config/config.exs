use Mix.Config

config :api_products,
  ecto_repos: [ApiProducts.Repo]

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

config :api_products, ApiProductsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+eH8hZnVIVGAac748xrqa1AkfBrgVdpDzPCFy3loo9hS1vTEmO7VVFiDsdVJKkyg",
  render_errors: [view: ApiProductsWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ApiProducts.PubSub,
  live_view: [signing_salt: "662xzens"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :logger,
  backends: [:console, Sentry.LoggerBackend]

import_config "#{Mix.env()}.exs"
