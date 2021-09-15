defmodule Aoc.Day02 do
  @behaviour Advent
  use Aoc.Boilerplate
  require IEx

  def setup do
    read_input()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def p1(program) do
    program
    |> Machine.new()
    |> Machine.restore_state(12, 2)
    |> Machine.run()
  end

  def p2(_input) do
    nil
  end
end
