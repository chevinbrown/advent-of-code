defmodule Aoc.Day06 do
  @behaviour Advent
  use Aoc.Boilerplate

  def setup do
    read_input() |> String.split() |> Enum.map(&String.split(&1, ")"))
  end

  def p1(input) do
    input
    |> build
  end

  def p2(input) do
  end

  def build(inputs) do
    Enum.reduce(inputs, %{}, fn [v1, v2], g ->
      g
      |> Map.update(v1, [v2], &[v2 | &1])
      |> Map.update(v2, [v1], &[v1 | &1])
    end)
  end
end
