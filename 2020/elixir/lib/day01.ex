defmodule Aoc.Day01 do
  @behaviour Advent
  use Aoc.Boilerplate

  def setup() do
    integer_stream()
  end

  def p1(input) do
    for x <- input,
        y <- input,
        x + y == 2020 do
      x * y
    end
    |> List.first()
  end

  def p2(input) do
    for x <- input, y <- input, z <- input, x + y + z == 2020 do
      x * y * z
    end
    |> List.first()
  end
end
