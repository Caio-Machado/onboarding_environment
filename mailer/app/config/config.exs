use Mix.Config

config :mailer, MailerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3q2QhWk9NwYvjnLqEYIcmhLPT5dL0iNknLUiXoXV0+LmQP4Z6cWRbz5IELH1/AhL",
  render_errors: [view: MailerWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Mailer.PubSub,
  live_view: [signing_salt: "oXrwkIn5"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :mailer, Mailer.Mailer, adapter: Bamboo.LocalAdapter

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
