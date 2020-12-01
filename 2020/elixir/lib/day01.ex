defmodule Aoc.Day01 do
  @behaviour Advent
  use Aoc.Boilerplate

  def setup() do
    integer_stream()
  end

  def p1(input) do
    perms =
      for x <- input,
          y <- input,
          x + y == 2020,
          do: {x, y}

    [{x, y} | _] = perms
    x * y
  end

  def p2(input) do
    perms =
      for x <- input,
          y <- input,
          z <- input,
          x + y + z == 2020,
          do: {x, y, z}

    [{x, y, z} | _] = perms
    x * y * z
  end
end
