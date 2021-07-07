defmodule ProbeSimulator.Probes.Create do

  alias ProbeSimulator.Probes.Repository

  def call() do
    probe = %{
      x: 0,
      y: 0,
      face: "D"
    }

    case Repository.insert(probe) do
      true  ->  {:ok, %{message: "Successfully created probe."}, :created}
      false ->  {:ok, %{message: "This space probe was created."}}
     {:error, reason}  ->  {:error, %{message: reason}}
    end
  end
end
