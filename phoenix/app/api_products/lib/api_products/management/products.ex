defmodule ApiProducts.Management.Products do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "products" do
    field(:sku, :string)
    field(:name, :string)
    field(:description, :string)
    field(:amount, :integer)
    field(:price, :float)
    field(:bar_code, :string)
  end

  def changeset(product, attrs) do
    product
    |> cast(attrs, [:sku, :name, :description, :amount, :price, :bar_code])
    |> validate_required([:sku, :name, :description, :amount, :price, :bar_code])
  end
end
