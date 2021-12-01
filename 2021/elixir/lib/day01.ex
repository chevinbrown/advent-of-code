defmodule Aoc.Day01 do
  @behaviour Advent
  use Aoc.Boilerplate

  def setup() do
    read_input()
  end

  def p1(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce({0, 0}, fn el, {prev, total} ->
      cond do
        # handle first condition
        {0, 0} == {prev, total} ->
          {el, total}

        el > prev ->
          {el, total + 1}

        true ->
          {el, total}
      end
    end)
    |> Tuple.to_list()
    |> Enum.at(1)
  end
end
