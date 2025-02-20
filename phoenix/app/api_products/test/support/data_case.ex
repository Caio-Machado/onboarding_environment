defmodule ApiProducts.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias ApiProducts.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import ApiProducts.DataCase
    end
  end

  setup tags do
    Mongo.Ecto.truncate(ApiProducts.Repo)
    ApiProducts.ElasticService.delete_all()
    ApiProducts.RedisService.delete_all()

    :ok
  end

  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Regex.replace(~r"%{(\w+)}", message, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
