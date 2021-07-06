defmodule SimuladorDeSonda.Sondas.CreateTest do
  use ExUnit.Case, async: true
  alias SimuladorDeSonda.Sondas.Create

  describe "call/0" do
    test "return a tuple with probe info, if its inserted." do
      probe = Create.call()

      expected_result = {
        :ok,
        %{
          face: "D",
          movements: [],
          position: %{
            x: 0,
            y: 0
          }
        },
        true
      }

      assert probe == expected_result
    end
  end
end
