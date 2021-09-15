defmodule Machine do
  require IEx

  def new(intcodes \\ []) do
    %{program: intcodes, ip: 0}
  end

  @doc """
  Day 2 Tests
  iex> step({%{0 => 1, 1 => 0, 2 => 0, 3 => 0, 4 => 99}, 0})
  [2,0,0,0,99]
  """
  def run({:halt, prog_set}), do: Enum.at(prog_set.program, 0)

  def run(prog_set) do
    run(step(prog_set))
  end

  def restore_state(prog_set, noun, verb) do
    ops =
      prog_set.program
      |> List.replace_at(1, noun)
      |> List.replace_at(2, verb)

    %{prog_set | program: ops}
    # restored =
    #   program
    #   |> Map.replace!(1, noun)
    #   |> Map.replace!(2, verb)

    # {restored, ip}
  end

  def to_instruction(%{program: program, ip: ip}) do
    intcodes = program
    opcode = Enum.at(program, ip)

    case opcode do
      1 ->
        {:add, [Enum.at(intcodes, ip + 1), Enum.at(intcodes, ip + 2)], Enum.at(intcodes, ip + 3),
         ip + 4}

      2 ->
        {:mul, [Enum.at(intcodes, ip + 1), Enum.at(intcodes, ip + 2)], Enum.at(intcodes, ip + 3),
         ip + 4}

      99 ->
        {:halt, []}

      _ ->
        throw("Unrecognized opcode: #{opcode}")
    end
  end

  def step(prog_set) do
    case to_instruction(prog_set) do
      {:add, [a, b], out, ip} ->
        # {program |> Map.replace!(out, a + b), ip + 4}
        ops = List.replace_at(prog_set.program, out, a + b)
        %{prog_set | ip: ip, program: ops}

      {:mul, [a, b], out, ip} ->
        ops = List.replace_at(prog_set.program, out, a * b)
        %{prog_set | ip: ip, program: ops}

      # {program |> Map.replace!(out, a * b), ip + 4}

      {:halt, _} ->
        {:halt, prog_set}
    end
  end
end
