defmodule SimuladorDeSonda.Sondas.RepositoryTest do
  use ExUnit.Case, async: true

  alias SimuladorDeSonda.Sondas.Repository

  @probe  %{
    position: %{x: 0, y: 0},
    movements: [],
    face: "D"
  }

  describe "insert/1" do
    test "insert a new probe on ETS table" do

      result = Repository.insert(@probe)

      expected_result = true
      assert result == expected_result
    end
  end

  describe "get/0" do
    test "return the probe inserted on ETS table" do
      Repository.insert(@probe)
      result = Repository.get()

      expected_result = %{face: "D", movements: [], position: %{x: 0, y: 0}}
      assert result == expected_result
    end
  end

end
