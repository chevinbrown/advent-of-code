defmodule Aoc.Day06 do
  @behaviour Advent
  use Aoc.Boilerplate

  def setup() do
    read_input()
    |> String.split("\n")
    |> Enum.chunk_by(&(&1 == ""))
    |> Enum.reject(&(&1 == [""]))
  end

  @doc """
  Find questions to which *anyone* answered "yes"
  """
  def p1(input) do
    input
    |> Enum.map(&all_answers/1)
    |> Enum.sum()
  end

  @doc """
  Find questions to which *everyone* answered "yes"
  """
  def p2(input) do
    input
    |> Enum.map(&same_answers/1)
    |> Enum.sum()
  end

  def all_answers(group) do
    group
    |> Enum.flat_map(&String.graphemes/1)
    |> Enum.uniq()
    |> Enum.count()
  end

  def same_answers(group) do
    group
    |> Enum.map(&MapSet.new(String.graphemes(&1)))
    |> Enum.reduce(&MapSet.intersection/2)
    |> Enum.count()
  end
end
