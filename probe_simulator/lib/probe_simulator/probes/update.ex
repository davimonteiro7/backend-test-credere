defmodule ProbeSimulator.Probes.Update do
  alias ProbeSimulator.Probes.Repository

  def call(movement) do
    movement
      |> handle_movement
      |> validate_movement
  end

  defp handle_movement(movements) do
    {_, probe,} = Repository.get()
    moviment_description = {[], 0, 0}
    tracked_probe = {probe, moviment_description}
    commands =
      movements
      |> Map.values()
      |> Enum.at(0)

    {moved_probe, {description, _, _}} = parse_commands(commands, tracked_probe)

    text_description = description
      |> Enum.map(fn {text, _} -> text end )
      |> Enum.join()

    {moved_probe, text_description}
  end

  defp validate_movement({moved_probe, text_description})
    when (moved_probe.x in 0..4) and (moved_probe.y in 0..4) do
      Repository.delete()
      case Repository.insert(moved_probe) do
        {:erro, reason} -> {:error, %{message: reason}}
        _   -> {:ok, %{ probe: %{x: moved_probe.x, y: moved_probe.y}, description: text_description}}
      end
  end
  defp validate_movement(_moved_probe),
    do: {:error , %{erro: "Um movimento inválido foi detectado, infelizmente a sonda ainda não possui a habilidade de se mover fora dos limites configurados (Quadrante 5x5)."}}


  defp parse_commands([], tracked_probe), do: tracked_probe
  defp parse_commands([command | tail_commands], current_tracked_probe) do
    tracked_probe = apply_command(command, current_tracked_probe)
    parse_commands(tail_commands, tracked_probe)
  end

  defp apply_command("GE", tracked_probe) do
    {probe, moviment_description} = tracked_probe
     new_description = mount_description(moviment_description, {" a sonda girou para a esquerda,", :turn})

    case probe.face do
      "E" -> { %{x: probe.x, y: probe.y, face: "B"}, new_description }
      "D" -> { %{x: probe.x, y: probe.y, face: "C"}, new_description }
      "C" -> { %{x: probe.x, y: probe.y, face: "E"}, new_description }
      "B" -> { %{x: probe.x, y: probe.y, face: "D"}, new_description }
    end
  end

  defp apply_command("GD", tracked_probe) do
    {probe, moviment_description} = tracked_probe
    new_description = mount_description(moviment_description, {" a sonda girou para a direita,", :turn})

    case probe.face do
      "E" -> { %{x: probe.x, y: probe.y, face: "C"}, new_description }
      "D" -> { %{x: probe.x, y: probe.y, face: "B"}, new_description }
      "C" -> { %{x: probe.x, y: probe.y, face: "D"}, new_description }
      "B" -> { %{x: probe.x, y: probe.y, face: "E"}, new_description }
    end
  end

  defp apply_command("M", tracked_probe) do
    {probe, moviment_description} = tracked_probe
    axis = get_axis(probe)
    new_description = mount_description(moviment_description, axis, 1)

    case probe.face do
      "E" -> { %{x: probe.x - 1, y: probe.y, face: probe.face}, new_description }
      "D" -> { %{x: probe.x + 1, y: probe.y, face: probe.face}, new_description }
      "C" -> { %{x: probe.x, y: probe.y + 1, face: probe.face}, new_description }
      "B" -> { %{x: probe.x, y: probe.y - 1, face: probe.face}, new_description }
    end
  end

  defp get_axis(probe) do
    case probe.face do
      "E" -> "x"
      "D" -> "x"
      "C" -> "y"
      "B" -> "y"
    end
  end

  defp mount_description({list_desc, x_movement, y_movement}, new_text) do
    {list_desc ++ [new_text], x_movement, y_movement}
  end

  defp mount_description({list_desc, x_movement, y_movement}, axis, squares) do
    last_item = List.last(list_desc)

    case list_desc do
      [] ->
        case axis do
          "x" -> {list_desc ++ [{" moveu #{x_movement + squares} casa(s) no eixo #{axis},", :move}], x_movement + 1 , y_movement}
          "y" -> {list_desc ++ [{" moveu #{y_movement + squares} casa(s) no eixo #{axis},", :move}], x_movement , y_movement + 1}
        end
       _ ->
        case last_item do

          {_, :turn} ->
            case axis do
              "x" -> {list_desc ++ [{" moveu #{x_movement + squares} casa(s) no eixo #{axis},", :move}], x_movement + 1 , y_movement}
              "y" -> {list_desc ++ [{" moveu #{y_movement + squares} casa(s) no eixo #{axis},", :move}], x_movement , y_movement + 1}
            end
          {_, :move} ->
            new_list = List.delete(list_desc, last_item)
            case axis do
              "x" -> {new_list ++ [{" moveu #{x_movement + squares} casa(s) no eixo #{axis},", :move}], x_movement + 1, y_movement}
              "y" -> {new_list ++ [{" moveu #{y_movement + squares} casa(s) no eixo #{axis},", :move}], x_movement , y_movement + 1}
            end
        end
    end
  end
end
