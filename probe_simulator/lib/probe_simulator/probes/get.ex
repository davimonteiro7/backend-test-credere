defmodule ProbeSimulator.Probes.Get do
  alias ProbeSimulator.Probes.Repository

  def call() do
    result = Repository.get();
    result
  end
end
