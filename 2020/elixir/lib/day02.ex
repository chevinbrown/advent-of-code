defmodule Aoc.Day02 do
  @behaviour Advent
  use Aoc.Boilerplate

  def setup() do
    read_input()
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
  end

  @doc """
  iex> p1(["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"])
  2
  """
  def p1(input) do
    input
    |> Enum.map(fn group ->
      [policy, password] = String.split(group, ": ")
      valid_password?(policy, password)
    end)
    |> Enum.reject(&(&1 == false))
    |> length()
  end

  @doc """
  iex> p2(["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"])
  1
  """
  def p2(input) do
    input
    |> Enum.map(fn group ->
      [policy, password] = String.split(group, ": ")
      official_valid_password?(policy, password)
    end)
    |> Enum.reject(&(&1 == false))
    |> length()
  end

  def valid_password?(policy, password) do
    [number, letter] = String.split(policy, " ")
    [min, max] = String.split(number, "-") |> Enum.map(&String.to_integer/1)

    letter_count = password |> String.graphemes() |> Enum.filter(&(&1 == letter)) |> length

    letter_count in min..max
  end

  def official_valid_password?(policy, password) do
    [positions, letter] = String.split(policy, " ")
    [first, last] = String.split(positions, "-") |> Enum.map(&String.to_integer/1)
    split_password = password |> String.graphemes()
    first_letter = split_password |> Enum.at(first - 1)
    last_letter = split_password |> Enum.at(last - 1)

    # must have exactly one occurrence
    matches =
      [first_letter == letter, last_letter == letter] |> Enum.filter(&(&1 == true)) |> length

    matches == 1
  end
end
