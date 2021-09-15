defmodule Aoc.Day12 do
  @behaviour Advent
  use Aoc.Boilerplate

  def setup() do
    read_input()
    |> String.trim()
    |> String.split("\n")
  end

  def p1(input) do
    {_heading, x, y} =
      input
      # {heading, x, y}, {0, 0, 0}
      |> Enum.reduce({90, 0, 0}, &move/2)

    abs(x) + abs(y)
  end

  def p2(input) do
  end

  def move(nav, {heading, x, y}) do
    {action, value} = String.split_at(nav, 1)
    value = value |> String.to_integer()

    case action do
      "N" ->
        {heading, x, y + value}

      "S" ->
        {heading, x, y - value}

      "E" ->
        {heading, x + value, y}

      "W" ->
        {heading, x - value, y}

      "L" ->
        {change_heading(heading, action, value), x, y}

      "R" ->
        {change_heading(heading, action, value), x, y}

      "F" ->
        [x, y] = determine_forward_direction(heading, x, y, value)
        {heading, x, y}
    end
  end

  def change_heading(heading, "L", value) do
    new_heading = heading - value

    if new_heading < 0 do
      new_heading + 360
    else
      new_heading
    end
  end

  def change_heading(heading, "R", value) do
    (heading + value) |> rem(360)
  end

  def determine_forward_direction(0, initial_x, initial_y, value),
    do: [initial_x, initial_y + value]

  def determine_forward_direction(90, initial_x, initial_y, value),
    do: [initial_x + value, initial_y]

  def determine_forward_direction(180, initial_x, initial_y, value),
    do: [initial_x, initial_y - value]

  def determine_forward_direction(270, initial_x, initial_y, value),
    do: [initial_x - value, initial_y]
end
