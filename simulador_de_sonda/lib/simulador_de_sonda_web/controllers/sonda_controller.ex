defmodule SimuladorDeSondaWeb.SondaController do
  use SimuladorDeSondaWeb, :controller

  alias SimuladorDeSonda.Sondas.Create

  def index(conn, _params) do
    Create.call()
    |> handle_response(conn)
  end

  defp handle_response({:ok, result}, conn), do: render_response(conn, result, :ok)
  defp handle_response({:error, result}, conn), do: render_response(conn, result, :bad_request)

  defp render_response(conn, _result, status) do
    conn
    |> put_status(status)
    |> json(%{result: "Space probe successfuly created."})
  end
end
