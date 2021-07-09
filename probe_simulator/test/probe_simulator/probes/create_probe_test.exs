defmodule ProbeSimulator.Probes.CreateProbeProbeTest do
  use ExUnit.Case, async: true
  alias ProbeSimulator.Probes.CreateProbe

  describe "call/0" do
    test "return a tuple, if a new probe was createProbed." do
      response = CreateProbe.call()
      assert {:ok, _, :createProbed} = response
    end

    test "return a tuple , if the same probe already exists " do
      CreateProbe.call()
      second_creation  = CreateProbe.call()

      expected_response = %{message: "This space probe was createProbed."}

      assert {:ok, ^expected_response, :createProbed} = second_creation
    end
  end
end
