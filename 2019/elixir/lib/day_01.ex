defmodule Aoc.Day01 do
  @behaviour Advent
  use Aoc.Boilerplate

  def setup() do
    integer_stream()
  end

  def p1(input) do
    input
    |> Stream.map(&required_fuel/1)
    |> Enum.sum()
  end

  def p2(input) do
    input
    |> Stream.map(&exact_fuel/1)
    |> Enum.sum()
  end

  @doc """
  ## Examples

      iex> Aoc.Day01.required_fuel(12)
      2

      iex> Aoc.Day01.required_fuel(100756)
      33583
  """
  def required_fuel(mass) do
    (div(mass, 3) - 2)
    |> max(0)
  end

  @doc """
  ## Examples

      iex> Aoc.Day01.exact_fuel(1969)
      966

      iex> Aoc.Day01.exact_fuel(100756)
      50346
  """
  def exact_fuel(mass) do
    mass
    |> Stream.iterate(&required_fuel/1)
    |> Stream.drop(1)
    |> Stream.take_while(&(&1 > 0))
    |> Enum.sum()
  end
end
