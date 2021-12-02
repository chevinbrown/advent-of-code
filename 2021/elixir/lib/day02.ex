defmodule Aoc.Day02 do
  @behaviour Advent
  use Aoc.Boilerplate

  def setup() do
    read_input()
    |> String.split("\n")
  end

  def p1(input) do
    input
    |> Enum.reduce([0, 0], &calculate_position/2)
    |> Enum.product()
  end

  def p2(input) do
    input
    |> Enum.reduce([0, 0, 0], &calculate_position_aim/2)
    |> Enum.take(2)
    |> Enum.product()
  end

  defp calculate_position("forward" <> " " <> distance, [x, y]) do
    [x + String.to_integer(distance), y]
  end

  defp calculate_position("up" <> " " <> distance, [x, y]) do
    [x, y + String.to_integer(distance)]
  end

  defp calculate_position("down" <> " " <> distance, [x, y]) do
    [x, y - String.to_integer(distance)]
  end

  defp calculate_position_aim("forward" <> " " <> distance, [x, y, t]) do
    distance = String.to_integer(distance)
    [x + distance, y + distance * t, t]
  end

  defp calculate_position_aim("up" <> " " <> distance, [x, y, t]) do
    [x, y, t - String.to_integer(distance)]
  end

  defp calculate_position_aim("down" <> " " <> distance, [x, y, t]) do
    [x, y, t + String.to_integer(distance)]
  end
end
