defmodule ApiProducts.ElasticService do
  import Tirexs.HTTP

  def add_product(product) do
    put("products/product/#{product.id}", format_json(product))
  end

  def delete_product(product_id) do
    delete("products/product/#{product_id}")
  end


  def filter_search(params) do
    case Enum.empty?(params) do
      false ->
        string_params = Enum.map_join(verify_params(params), "%20AND%20", fn({k, v}) -> "#{k}:#{v}" end)
        verify_result(get("products/product/_search?q=" <> string_params))

      _true -> params
    end
  end


  defp verify_params(params) do
    params
    |> modify_param(params["c_amount"], {"amount", "c_amount"})
    |> modify_param(params["c_price"], {"price", "c_price"})
  end


  defp modify_param(params, "gt", {param, c_param}) do
    {_, result} = Map.pop(params, c_param)
    Map.put(result, param, "%3E#{Map.get(result, param)}")
  end

  defp modify_param(params, "lt", {param, c_param}) do
    {_, result} = Map.pop(params, c_param)
    Map.put(result, param, "%3C#{Map.get(result, param)}")
  end

  defp modify_param(params, _, _), do: params


  defp verify_result({:ok, 200, result}), do: format_result(result[:hits][:hits])

  defp verify_result(:error), do: {:error, :internal_server_error}

  defp verify_result(result), do: result


  defp format_result(result) do
    {:ok, Enum.map(result, fn(p) -> Map.delete(p[:_source], :last_update) end)}
  end

  defp format_json(product) do
    %{
      id: product.id,
      sku: product.sku,
      name: product.name,
      description: product.description,
      amount: product.amount,
      price: product.price,
      last_update: DateTime.to_iso8601(DateTime.utc_now())
    }
  end
end
