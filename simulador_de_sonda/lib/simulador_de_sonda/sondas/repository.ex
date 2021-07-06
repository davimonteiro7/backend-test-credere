defmodule SimuladorDeSonda.Sondas.Repository do

  def insert(probe) do
    create_table()
    :ets.insert_new(:probe_cache, {[probe]})
  end

  def get() do
    :ets.first(:probe_cache)
    |> List.first()
  end

  defp create_table(), do: :ets.new(:probe_cache, [:duplicate_bag, :public, :named_table])
end
