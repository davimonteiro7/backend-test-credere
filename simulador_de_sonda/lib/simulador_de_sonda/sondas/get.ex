defmodule SimuladorDeSonda.Sondas.Get do
  alias SimuladorDeSonda.Sondas.Repository

  def call() do
    result = Repository.get();
    {:ok, result}
  end
end
