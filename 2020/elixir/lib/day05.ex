defmodule Aoc.Day05 do
  @behaviour Advent
  use Aoc.Boilerplate

  def setup() do
    read_input()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
  end

  @doc """
  iex> p1(["BFFFBBFRRR"])
  567
  """
  def p1(input) do
    input
    |> Enum.map(&seat_id/1)
    |> Enum.max()
  end

  @doc """
  iex> p2(["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"])
  1
  """
  def p2(input) do
    input
    |> Enum.map(&seat_id/1)
    |> Enum.sort()
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.find(&match?([a, b] when a != b - 1, &1))
    |> Enum.reduce(&+/2)
    |> Kernel.div(2)
  end

  def seat_id(bin) do
    bin
    |> String.graphemes()
    |> Enum.map(fn char -> if char in ["B", "R"], do: 1, else: 0 end)
    |> Integer.undigits(2)
  end
end
