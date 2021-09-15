defmodule Aoc.Day13 do
  @behaviour Advent
  use Aoc.Boilerplate

  def setup() do
    read_input()
    |> String.replace("x,", "")
    |> String.split("\n", trim: true)
  end

  def p1([departure, busses]) do
    departure = String.to_integer(departure)

    buss_id =
      busses
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.min_by(&(&1 - rem(departure, &1)))

    wait = buss_id - rem(departure, buss_id)
    buss_id * wait
  end

  def p2(input) do
  end
end
