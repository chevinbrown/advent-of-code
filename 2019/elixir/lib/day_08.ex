defmodule Aoc.Day08 do
  @behaviour Advent
  use Aoc.Boilerplate
  @height 6
  @width 25

  def setup do
    read_input()
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def p1(input) do
    input
    |> to_layers(@height, @width)
    |> layer_min_count(0)
    |> digit_multpl(1, 2)
  end

  def p2(input) do
  end

  def to_layers(pixels, h, w) do
    pixels |> Enum.chunk_every(w * h)
  end

  def layer_min_count(layers, matching) do
    Enum.min_by(layers, fn l -> Enum.count(l, &(&1 == matching)) end)
  end

  def digit_multpl(layer, counta, countb) do
    Enum.count(layer, &(&1 == counta)) * Enum.count(layer, &(&1 == countb))
  end
end
