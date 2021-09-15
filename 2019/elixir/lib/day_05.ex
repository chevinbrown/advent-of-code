defmodule Aoc.Day05 do
  @behaviour Advent
  use Aoc.Boilerplate

  @output 19_690_720

  def setup do
    read_input()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def p1(input, noun \\ 12, verb \\ 2) do
    input
    |> intcode(noun, verb)
    |> hd()
  end

  def p2(input) do
    nil
    # for(
    #   noun <- 0..99,
    #   verb <- 0..99,
    #   input |> intcode(noun, verb) |> hd() == @output,
    #   do: 100 * noun + verb
    # )
    # |> hd()
  end

  @doc """
    ## Example
        # iex> intcode([1,0,0,0,99], 12, 2)
        # [2,0,0,0,99]
  """
  def intcode(input, noun, verb) do
    input
    |> List.update_at(1, fn _ -> noun end)
    |> List.update_at(2, fn _ -> verb end)
    |> run()
  end

  def run(program, position \\ 0)

  def run({:halt, program}, _position), do: program

  def run(program, position) do
    program
    |> Enum.drop(position)
    |> do_run(program)
    |> run(position + 4)
  end

  defp do_run([99 | _], program), do: {:halt, program}

  defp do_run([1, input1, input2, output | _], program) do
    result = Enum.at(program, input1) + Enum.at(program, input2)
    List.update_at(program, output, fn _ -> result end)
  end

  defp do_run([2, input1, input2, output | _], program) do
    result = Enum.at(program, input1) * Enum.at(program, input2)
    List.update_at(program, output, fn _ -> result end)
  end

  defp do_run([3, input, target | _], program) do
    List.update_at(program, target, fn _ -> input end)
  end

  defp do_run([4, target | _], program) do
    Enum.at(program, target)

    # List.update_at(program, output, fn _ -> result end)
  end
end
