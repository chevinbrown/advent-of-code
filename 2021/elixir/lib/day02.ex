defmodule Aoc.Day02 do
  @behaviour Advent
  use Aoc.Boilerplate

  def setup() do
    read_input()
    |> String.split("\n")
    |> IO.inspect()
  end

  def p1(input) do
    [x, y] =
      input
      |> Enum.reduce([0, 0], &calculate_position/2)

    x * y
  end

  def p2(_) do
    nil
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
end
