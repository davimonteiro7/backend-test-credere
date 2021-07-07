defmodule ProbeSimulatorWeb.ProbeController do
  use ProbeSimulatorWeb, :controller

  alias ProbeSimulator.Probes.{Create, Get, Update}

  def create(conn, _params) do
    Create.call()
    |> handle_response(conn)
  end

  def get(conn, _params) do
    Get.call()
    |> handle_response(conn)
  end

  def move_probe(conn, _params) do
    read_body(conn)
      |> handle_request()
      |> Update.call
      |> handle_response(conn)

  end

  defp handle_request({:ok, _, body}) do
    body |> Map.get(:body_params)
  end

  defp handle_response({:ok, result}, conn) do
    conn
    |> put_status(:ok)
    |> json(result)
  end

  defp handle_response({:error, result}, conn) do
    conn
    |> put_status(:bad_request)
    |> json(result)
  end

  defp handle_response({:ok, result, status}, conn) do
    conn
    |> put_status(status)
    |> json(result)
  end
end
