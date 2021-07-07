defmodule ProbeSimulator.Probes.Update do
  alias ProbeSimulator.Probes.Repository

  def call(movement) do
    movement
      |> handle_movement
      |> validate_movement
  end

  defp handle_movement(movements) do
    {_, probe,} = Repository.get()
    commands = movements |> Map.values() |> Enum.at(0)
    parse_commands(commands, probe)
  end

  defp validate_movement(moved_probe)
    when (moved_probe.x in 0..4) and (moved_probe.y in 0..4) do
      Repository.delete()
      case Repository.insert(moved_probe) do
        {:erro, reason} -> {:error, %{message: reason}}
        _   -> {:ok, %{x: moved_probe.x, y: moved_probe.y}}
      end
  end
  defp validate_movement(_moved_probe),
    do: {:error , %{erro: "Um movimento inválido foi detectado, infelizmente a sonda ainda não possui a habilidade de #vvv"}}


  defp parse_commands([], probe), do: probe
  defp parse_commands([command | tail_commands], current_probe) do
    probe = apply_command(command, current_probe)
    parse_commands(tail_commands, probe)
  end

  defp apply_command("GE", probe) do
    case probe.face do
      "E" -> %{x: probe.x, y: probe.y, face: "B"}
      "D" -> %{x: probe.x, y: probe.y, face: "C"}
      "C" -> %{x: probe.x, y: probe.y, face: "E"}
      "B" -> %{x: probe.x, y: probe.y, face: "D"}
    end
  end

  defp apply_command("GD", probe) do
    case probe.face do
      "E" -> %{x: probe.x, y: probe.y, face: "C"}
      "D" -> %{x: probe.x, y: probe.y, face: "B"}
      "C" -> %{x: probe.x, y: probe.y, face: "D"}
      "B" -> %{x: probe.x, y: probe.y, face: "E"}
    end
  end

  defp apply_command("M", probe) do
    case probe.face do
      "E" -> %{x: probe.x - 1, y: probe.y, face: probe.face}
      "D" -> %{x: probe.x + 1, y: probe.y, face: probe.face}
      "C" -> %{x: probe.x, y: probe.y + 1, face: probe.face}
      "B" -> %{x: probe.x, y: probe.y - 1, face: probe.face}
    end
  end
end
