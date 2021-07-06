defmodule ProbeSimulator.Probes.Create do

  alias ProbeSimulator.Probes.Repository

  def call() do
    probe = %{
      position: %{x: 0, y: 0},
      movements: [],
      face: "D"
    }
    status = :created
    Repository.insert(probe)
    |> Tuple.append(status)
  end
end
