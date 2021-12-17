defmodule ApiProducts.Repo.Migrations.CreateMyappDevelopment do
  use Ecto.Migration

  def change do
    create table(:product) do
      add :string
      add :sku, :string
      add :name, :string
      add :price, :float
      add :amount, :integer
      add :description, :string

      timestamps()
    end

  end
end
