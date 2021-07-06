defmodule ProbeSimulator.Probes.CreateTest do
  use ExUnit.Case, async: true
  alias ProbeSimulator.Probes.Create

  describe "call/0" do
    test "return a tuple, if a new probe was created." do
      response = Create.call()
      assert {:ok, _, :created} = response
    end

    test "return a tuple , if the same probe already exists " do
      Create.call()
      second_creation  = Create.call()

      expected_response = %{message: "This space probe was created."}

      assert {:ok, ^expected_response, :created} = second_creation
    end
  end
end
