use Mix.Config

config :api_products,
  ecto_repos: [ApiProducts.Repo]

config :api_products, Repo,
  adapter: Mongo.Ecto,
  database: "myapp_development",
  hostname: "localhost"

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

import_config "#{Mix.env()}.exs"
