defmodule ApiProductsWeb.ProductsView do
  use ApiProductsWeb, :view
  alias ApiProductsWeb.ProductsView
  alias ApiProductsWeb.ChangesetView

  def render("index.json", %{products: products}) do
    %{products: render_many(products, ProductsView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{product: render_one(product, ProductsView, "product.json")}
  end

  def render("product.json", %{products: product}) do
    %{id: product.id,
      sku: product.sku,
      name: product.name,
      description: product.description,
      amount: product.amount,
      price: product.price}
  end

  def render("error.json", %{product: result}) do
    render_one(result, ChangesetView, "error.json")
  end
end
