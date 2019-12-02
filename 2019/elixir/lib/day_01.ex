defmodule Aoc.Day01 do
  use Aoc.Boilerplate

  def run() do
    IO.inspect(part1())
    IO.inspect(part2())
  end

  def part1() do
    integer_stream()
    |> Stream.map(&required_fuel/1)
    |> Enum.sum()
  end

  def part2() do
    integer_stream()
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
