defmodule ApiProducts.MixProject do
  use Mix.Project

  def project do
    [
      app: :api_products,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {ApiProducts.Application, []},
      extra_applications: [
        :logger,
        :runtime_tools,
        :mongodb_ecto,
        :tirexs,
        :task_bunny,
        :httpoison,
        :sentry
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support", "test/api_products/fixtures"]

  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:phoenix, "~> 1.5.13"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_live_dashboard, "~> 0.4"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:mongodb_ecto, github: "michalmuskala/mongodb_ecto"},
      {:redix, "~> 1.1"},
      {:tirexs, "~> 0.8"},
      {:mock, "~> 0.3.0", only: :test},
      {:task_bunny, "~> 0.3.1"},
      {:csv, "~> 2.4.1"},
      {:httpoison, "~> 1.8"},
      {:hackney, "~> 1.8"},
      {:sentry, "~> 8.0"},
      {:spandex, "~> 3.0.3"},
      {:spandex_phoenix, "~> 0.2"},
      {:spandex_ecto, "~> 0.2"},
      {:decorator, "~> 1.2"},
      {:spandex_datadog, "~> 1.2"}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "test"]
    ]
  end
end
