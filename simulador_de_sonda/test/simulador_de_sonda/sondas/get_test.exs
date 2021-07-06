defmodule SimuladorDeSonda.Sondas.GetTest do
  use ExUnit.Case, async: true

  alias SimuladorDeSonda.Sondas.Get

  describe "call/0" do
    test "return a tuple {:ok, probe}, if exist a valid probe." do
      SimuladorDeSonda.Sondas.Create.call()

      response =  Get.call()

      assert {:ok, _result} = response
    end
  end
end
