defmodule SimuladorDeSonda.Sondas.Create do

  alias SimuladorDeSonda.Sondas.Repository

  def call() do
    probe = %{
      position: %{x: 0, y: 0},
      movements: [],
      face: "D"
    }

    result = Repository.insert(probe)
    {:ok, probe, result}
  end
end
