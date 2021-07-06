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

  defp handle_response({:ok, result}, conn) do
    conn
    |> put_status(:ok)
    |> json(result)
  end

  defp handle_response({:ok, result, status}, conn) do
    conn
    |> put_status(status)
    |> json(result)
  end

  defp handle_response({:error, reason, status}, conn) do
    conn
    |> put_status(status)
    |> json(reason)
  end
end
