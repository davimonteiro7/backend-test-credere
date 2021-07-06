defmodule ProbeSimulator.Probes.Create do

  alias ProbeSimulator.Probes.Repository

  def call() do
    probe = %{
      position: %{x: 0, y: 0},
      movements: [],
      face: "D"
    }

    case Repository.insert(probe) do
      true  ->  {:ok, %{message: "Successfully created probe."}, :created}
      false ->  {:ok, %{message: "This space probe was created."}, :created}
        _   ->  {:error, %{message: "Check if the cache table is created."}, :bad_request}
    end
  end
end
