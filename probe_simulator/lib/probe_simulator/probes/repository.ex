defmodule ProbeSimulator.Probes.Repository do

  def insert(probe) do
    create_table()

    case :ets.insert_new(:probe_cache, {[probe]}) do
      true ->  {:ok, "Space probe successfuly created."}
      false -> {:error, "Cannot register this space probe."}
    end
  end

  def get() do
    result = :ets.first(:probe_cache)
    |> List.first()

    {:ok, result}
  end

  defp create_table(), do: :ets.new(:probe_cache, [:duplicate_bag, :public, :named_table])
end
