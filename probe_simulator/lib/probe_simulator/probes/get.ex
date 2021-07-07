defmodule ProbeSimulator.Probes.Get do
  alias ProbeSimulator.Probes.Repository

  def call() do
    result = Repository.get()

    case result do
      {:ok, result } -> {:ok, result}
      {:error, reason} -> {:error, %{message: reason}, :bad_request}
    end
  end
end
