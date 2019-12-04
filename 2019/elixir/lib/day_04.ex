defmodule Aoc.Day04 do
  @behaviour Advent
  use Aoc.Boilerplate

  @password_range 234_208..765_869

  def setup do
    @password_range
    |> Enum.map(&Integer.digits/1)
  end

  @doc """
  It is a six-digit number.
  The value is within the range given in your puzzle input.
  Two adjacent digits are the same (like 22 in 122345).
  Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).
  """
  def p1(input) do
    input
    |> Enum.reject(&decreasing?/1)
    |> Enum.filter(&has_double?/1)
    |> Enum.count()
  end

  def p2(input) do
  end

  @doc """
    ## Examples
        iex> Aoc.Day04.has_double?([1, 1, 1, 1, 1, 1])
        true

       iex> Aoc.Day04.has_double?([1, 2, 3, 7, 8, 9])
       false
  """
  def has_double?(password) do
    password
    |> chunked
    |> Enum.any?(fn [a, b] -> a == b end)
  end

  @doc """
    ## Examples
        iex> Aoc.Day04.decreasing?([1, 1, 1, 1, 1, 1])
        false

       iex> Aoc.Day04.decreasing?([1, 2, 3, 7, 8, 9])
       false

       iex> Aoc.Day04.decreasing?([2, 2, 3, 4, 5, 0])
       true
  """
  def decreasing?(password) do
    password
    |> chunked()
    |> Enum.any?(fn [a, b] -> a > b end)
  end

  defp chunked(password) do
    password
    |> Enum.chunk_every(2, 1, :discard)
  end
end
