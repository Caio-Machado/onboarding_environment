defmodule ApiProducts.Application do
  use Application

  def start(_type, _args) do
    children = [
      ApiProducts.Repo,
      ApiProductsWeb.Telemetry,
      {Phoenix.PubSub, name: ApiProducts.PubSub},
      ApiProductsWeb.Endpoint,
      {Redix, {"redis://localhost:6379", [name: :redis_server]}}
    ]

    opts = [strategy: :one_for_one, name: ApiProducts.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    ApiProductsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
