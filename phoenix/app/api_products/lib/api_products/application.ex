defmodule ApiProducts.Application do
  use Application

  import Supervisor.Spec

  def start(_type, _args) do
    spandex_opts = [
      host: "http://127.0.0.1",
      port: 8126,
      batch_size: 10,
      sync_threshold: 100,
      http: HTTPoison
    ]

    Logger.add_backend(Sentry.LoggerBackend)

    children = [
      {SpandexDatadog.ApiServer, spandex_opts},
      ApiProducts.Repo,
      ApiProductsWeb.Telemetry,
      {Phoenix.PubSub, name: ApiProducts.PubSub},
      ApiProductsWeb.Endpoint,
      {Redix,
       {"redis://localhost:6379/#{Application.get_env(:api_products, :redis_server)}",
        [name: :redis_server]}}
    ]

    opts = [strategy: :one_for_one, name: ApiProducts.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    ApiProductsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
