defmodule ApiProductsWeb.SaveLogPlug do
  import Plug.Conn
  import Tirexs.HTTP

  def init(props) do
    props
  end

  def call(conn, _) do
    register_before_send(conn, fn conn ->
      post("/logs/requests/", format_response(conn))
      conn
    end)
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
      body_params: response.body_params,
      req_cookies: response.req_cookies,
      request_path: response.request_path,
      resp_cookies: response.resp_cookies,
      scheme: response.scheme,
      state: response.state,
      status: response.status,
      date: DateTime.to_iso8601(DateTime.utc_now())
    }
  end
end
