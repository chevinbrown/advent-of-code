defmodule Aoc.Day09 do
  @behaviour Advent
  use Aoc.Boilerplate

  @preamble 25

  def setup() do
    read_input()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end

  def p1(input) do
    input
    |> Enum.chunk_every(@preamble + 1, 1, :discard)
    |> Enum.map(&invalid_numbers/1)
    |> Enum.reject(&is_nil/1)
    |> List.first()
  end

  def p2(input) do
  end

  def invalid_numbers(chunk) do
    max = List.last(chunk)

    matches =
      for x <- chunk, y <- chunk do
        x + y == max
      end
      |> Enum.uniq()

    if !Enum.any?(matches), do: max
  end
end
