defmodule ApiProducts.Management do
  import Ecto.Query, warn: false
  alias ApiProducts.Repo

  alias ApiProducts.Management.Products

  def list_myapp_development do
    Repo.all(Products)
  end

  def get_product!(id), do: Repo.get(Products, id)

  def create_product(attrs \\ %{}) do
    %Products{}
    |> Products.changeset(attrs)
    |> Repo.insert()
  end

  def update_product(%Products{} = product, attrs) do
    product
    |> Products.changeset(attrs)
    |> Repo.update()
  end

  def delete_product(%Products{} = product) do
    Repo.delete(product)
  end

  def change_product(%Products{} = product, attrs \\ %{}) do
    Products.changeset(product, attrs)
  end
end
