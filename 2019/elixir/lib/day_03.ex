defmodule Aoc.Day03 do
  @behaviour Advent
  use Aoc.Boilerplate

  def setup do
    [wire1, wire2] =
      read_input()
      |> read_wires
      |> Enum.map(&follow_wire/1)

    intersections =
      wire1
      |> MapSet.new()
      |> MapSet.intersection(MapSet.new(wire2))
      |> MapSet.delete({0, 0})

    %{wires: {wire1, wire2}, intersections: intersections}
  end

  @doc """
  Returns a list of binary(direction) & integer(distance)
  ## Examples

      iex> Aoc.Day03.read_wires("R32,D12\\nU90,L1")
      [[{82, 32}, {68, 12}],[{85, 90}, {76, 1}]]
  """
  def read_wires(string) do
    string
    |> String.split("\n", trim: true)
    |> Enum.map(fn x ->
      x
      |> String.split(",", trim: true)
      |> Enum.map(&make_instruction/1)
    end)
  end

  def make_instruction(<<direction::utf8, distance::binary>>) do
    {direction, distance |> String.to_integer()}
  end

  def next_coord([{x, y} | _], ?U), do: {x, y + 1}
  def next_coord([{x, y} | _], ?D), do: {x, y - 1}
  def next_coord([{x, y} | _], ?L), do: {x - 1, y}
  def next_coord([{x, y} | _], ?R), do: {x + 1, y}

  def follow_wire(wire), do: follow_wire(wire, [{0, 0}])
  def follow_wire([], history), do: history
  def follow_wire([{_, 0} | tail], history), do: follow_wire(tail, history)

  def follow_wire([{dir, distance} | tail], history) do
    follow_wire([{dir, distance - 1} | tail], [next_coord(history, dir) | history])
  end

  def p1(%{intersections: intersections}) do
    intersections
    |> Enum.min_by(fn {x, y} -> abs(x) + abs(y) end)
    |> (fn {x, y} -> abs(x) + abs(y) end).()
  end

  @doc """
  calculate the number of steps each wire takes to reach each intersection;
  choose the intersection where the sum of both wires' steps is lowest. If a
  wire visits a position on the grid multiple times, use the steps value from
  the first time it visits that position when calculating the total value of a
  specific intersection.
  """
  def p2(%{wires: {wire1, wire2}, intersections: intersections}) do
    intersections
    |> Enum.map(fn coord ->
      Enum.find_index(Enum.reverse(wire1), &(coord == &1)) +
        Enum.find_index(Enum.reverse(wire2), &(coord == &1))
    end)
    |> Enum.min()
  end
end
