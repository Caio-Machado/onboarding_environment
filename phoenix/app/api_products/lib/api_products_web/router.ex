defmodule ApiProductsWeb.Router do
  use ApiProductsWeb, :router
  use Sentry.PlugCapture
  # use Spandex.Decorators
  use SpandexPhoenix

  pipeline :api do
    plug(:accepts, ["json"])
    plug Sentry.PlugContext
  end

  scope "/", ApiProductsWeb do
    pipe_through(:api)

    resources("/products", ProductsController, except: [:new, :edit])
    get "/report", ReportController, :get_report
    post "/report", ReportController, :update_report
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through([:fetch_session, :protect_from_forgery])
      live_dashboard("/dashboard", metrics: ApiProductsWeb.Telemetry)
    end
  end
end
