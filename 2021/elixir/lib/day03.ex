defmodule Aoc.Day03 do
  @behaviour Advent
  use Aoc.Boilerplate

  def setup() do
    read_input()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.codepoints/1)
  end

  def p1(input) do
    inverted =
      input
      |> List.zip()
      |> Enum.map(&Tuple.to_list/1)

    mode = inverted |> Enum.map(&mode/1) |> Enum.join() |> Integer.parse(2) |> elem(0)
    anti_mode = inverted |> Enum.map(&anti_mode/1) |> Enum.join() |> Integer.parse(2) |> elem(0)
    mode * anti_mode
  end

  def p2(input) do
    input
  end

  def mode(list) do
    gb = Enum.group_by(list, & &1)
    max = Enum.map(gb, fn {_, val} -> length(val) end) |> Enum.max()
    for {key, val} <- gb, length(val) == max, do: key
  end

  def anti_mode(list) do
    gb = Enum.group_by(list, & &1)
    min = Enum.map(gb, fn {_, val} -> length(val) end) |> Enum.min()
    for {key, val} <- gb, length(val) == min, do: key
  end
end
