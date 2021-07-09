defmodule ProbeSimulator.Probes.GetProbeProbeTest do
  use ExUnit.Case, async: true

  alias ProbeSimulator.Probes.GetProbe

  describe "call/0" do
    test "return a tuple {:ok, probe}, if exist a valid probe." do
      ProbeSimulator.Probes.Create.call()

      response =  GetProbe.call()

      assert {:ok, _result} = response
    end
  end
end
