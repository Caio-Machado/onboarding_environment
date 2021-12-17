defmodule ApiProducts.Repo do
  use Ecto.Repo,
    otp_app: :api_products,
    adapter: Mongo.Ecto
end
