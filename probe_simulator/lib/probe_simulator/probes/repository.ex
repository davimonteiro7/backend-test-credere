defmodule ProbeSimulator.Probes.Repository do
  use GenServer

  @name __MODULE__

  def start_link(_), do: GenServer.start_link(__MODULE__, [], name: @name)

  def init(_) do
    IO.puts("Creating ETS #{@name}")
    :ets.new(:probe_cache, [:duplicate_bag, :public, :named_table])
    {:ok, "ETS Created"}
  end

  def insert(probe) do
    GenServer.call(@name, {:insert, probe})
  end

  def get() do
    GenServer.call(@name, :get)
  end

  def handle_call(:get, _ref, state) do
    result = :ets.first(:probe_cache)
    case result do
      :"$end_of_table" -> {:reply, {:error, "This probe was not created."}, state}
      _ -> {:reply, {:ok, result}, state}
    end

  end

  def handle_call({:insert, data}, _ref, state) do
    result = :ets.insert_new(:probe_cache, {[data]})
    case result do
      {:error, _} -> {:reply, {:error, "Inexistent ETS table"}, state}
      _ -> {:reply, result, state}
    end
  end
end
