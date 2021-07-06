defmodule ProbeSimulator.Probes.Get do
  alias ProbeSimulator.Probes.Repository

  def call() do
    result = Repository.get()

    case result do
      {:ok, result } -> {:ok, parse_result(result)}
      {:error, reason} -> {:error, %{message: reason}, :bad_request}
    end
  end

  defp parse_result(result) do
    IO.inspect(result)
    probe = result |> List.first()
    position = probe |> Map.get(:position)

    %{x: Map.get(position, :x),
      y: Map.get(position, :y),
      face: Map.get(probe, :face)
    }
  end
end
