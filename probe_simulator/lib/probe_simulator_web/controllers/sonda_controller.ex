defmodule ProbeSimulatorWeb.ProbeController do
  use ProbeSimulatorWeb, :controller

  alias ProbeSimulator.Probes.{Create, Get}

  def create(conn, _params) do
    Create.call()
    |> handle_response(conn)
  end

  def get(conn, _params) do
    Get.call()
    |> handle_response(conn)
  end

  defp handle_response({:ok, result, status}, conn),    do: render_response(conn, result, status)
  defp handle_response({:error, _}, conn),    do: render_response(conn, :bad_request)

  defp render_response(conn, result, :ok) do
    conn
    |> put_status(:ok)
    |> json(result)
  end

  defp render_response(conn, result, status) do
    conn
    |> put_status(status)
    |> json(result)
  end

  defp render_response(conn, :bad_request) do
    conn
    |> put_status(:bad_request)
    |> json(%{error: "Um movimento inválido foi detectado."})
  end
end
