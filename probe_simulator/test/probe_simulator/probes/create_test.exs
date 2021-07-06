defmodule ProbeSimulator.Probes.CreateTest do
  use ExUnit.Case, async: true
  alias ProbeSimulator.Probes.Create

  describe "call/0" do
    test "return a tuple with probe info, if its inserted." do
      response = Create.call()
      assert {:ok, _, :created} = response
    end
  end
end
