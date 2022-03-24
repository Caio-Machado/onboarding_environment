defmodule Mailer.MixProject do
  use Mix.Project

  def project do
    [
      app: :mailer,
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
      mod: {Mailer.Application, []},
      extra_applications: [:logger, :runtime_tools, :bamboo]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:phoenix, "~> 1.5.13"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:bamboo, "~> 2.2.0"},
      {:mock, "~> 0.3.0", only: :test},
      {:httpoison, "~> 1.8"},
      {:sentry, "~> 8.0"},
      {:spandex, "~> 3.0.3"},
      {:decorator, "~> 1.2"},
      {:spandex_phoenix, "~> 1.0.5"},
      {:spandex_ecto, "~> 0.7"},
      {:spandex_datadog, "~> 1.2"}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "cmd npm install --prefix assets"]
    ]
  end
end
