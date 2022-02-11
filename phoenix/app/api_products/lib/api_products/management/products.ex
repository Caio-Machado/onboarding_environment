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
    field(:barcode, :string)
  end

  def changeset(product, attrs) do
    product
    |> cast(attrs, [:sku, :name, :description, :amount, :price, :barcode])
    |> validate_required([:sku, :name, :description, :amount, :price, :barcode])
    |> validate_format(:sku, ~r/^([a-zA-Z0-9]|-)+$/)
    |> validate_number(:price, greater_than: 0)
    |> validate_length(:barcode, min: 8, max: 13)
  end
end
