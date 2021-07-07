defmodule ProbeSimulator.Probes.RepositoryTest do
  use ExUnit.Case, async: true

  alias ProbeSimulator.Probes.Repository

  @probe  %{
    x: 0,
    y: 0,
    face: "D"
  }

  describe "insert/1" do
    test "insert a new probe on ETS table" do
      :ets.delete_all_objects(:probe_cache)
      response = Repository.insert(@probe)
      assert response == true
    end
  end

  describe "get/0" do
    test "return the probe inserted on ETS table" do
      Repository.insert(@probe)
      result = Repository.get()

      expected_result = {:ok, [%{face: "D", movements: [], position: %{x: 0, y: 0}}]}
      assert result == expected_result
    end
  end
end
