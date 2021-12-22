defmodule ApiProductsWeb.LogstashController do
  import Tirexs.HTTP

  def save_log(response) do
    post("/products/product/", format_response(response))
    response
  end

  defp format_response(response) do
    %{
      cookies: response.cookies,
      halted: response.halted,
      host: response.host,
      method: response.method,
      params: response.params,
      port: response.port,
      query_params: response.query_params,
      query_string: response.query_string,
      req_cookies: response.req_cookies,
      request_path: response.request_path,
      resp_body: response.resp_body,
      resp_cookies: response.resp_cookies,
      scheme: response.scheme,
      state: response.state,
      status: response.status
    }
  end
end
