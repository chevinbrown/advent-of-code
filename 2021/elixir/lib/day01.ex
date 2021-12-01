defmodule Aoc.Day01 do
  @behaviour Advent
  use Aoc.Boilerplate

  def setup() do
    read_input()
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end

  def p1(input) do
    input
    |> Enum.reduce({0, 0}, &count_increase/2)
    |> elem(1)
  end

  def p2(input) do
    input
    |> Enum.chunk_every(3, 1)
    |> Enum.map(&Enum.sum/1)
    |> Enum.reduce({0, 0}, &count_increase/2)
    |> elem(1)
  end

  defp count_increase(el, {0, 0} = {_, total}), do: {el, total}
  defp count_increase(el, {prev, total}) when el > prev, do: {el, total + 1}
  defp count_increase(el, {_, total}), do: {el, total}
end
