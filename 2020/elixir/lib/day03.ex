defmodule Aoc.Day03 do
  @behaviour Advent
  use Aoc.Boilerplate

  def setup() do
    read_input()
  end

  def p1(input) do
    count_trees_for_slope(input, 3, 1)
  end

  def p2(input) do
    [
      [1, 1],
      [3, 1],
      [5, 1],
      [7, 1],
      [1, 2]
    ]
    |> Enum.map(fn [x_slope, y_slope] -> count_trees_for_slope(input, x_slope, y_slope) end)
    |> List.foldl(1, fn x, acc -> x * acc end)
  end

  def count_trees_for_slope(input, x_slope, y_slope) do
    height = input |> String.split() |> Enum.count()

    [_, _, trees] =
      0..(height - 1)
      |> Enum.reduce([0, 0, 0], fn _y_index, acc ->
        [x, y, count] = acc
        x = x + x_slope
        y = y + y_slope

        new_count =
          if map_point_value(input, x, y) == "#" do
            count + 1
          else
            count
          end

        [x, y, new_count]
      end)

    trees
  end

  def map_point_value(map, x, y) do
    line = map |> String.split() |> Enum.at(y)

    if is_nil(line) do
      "."
    else
      width = String.length(line)

      value =
        line
        |> String.graphemes()
        |> Enum.at(rem(x, width))

      value
    end
  end
end
