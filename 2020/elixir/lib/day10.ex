defmodule Aoc.Day10 do
  @behaviour Advent
  use Aoc.Boilerplate

  def setup() do
    read_input()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
  end

  def p1(input) do
    {diff_1, diff_3, _} =
      input
      |> find_sequential()

    diff_1 * diff_3
  end

  def p2(input) do
    {:ok, agent} = Agent.start(fn -> %{} end)

    input
    |> memoized_find_arrangements(0, agent)
  end

  def find_sequential(joltages) do
    Enum.reduce(joltages, {0, 1, 0}, fn joltage, {diffs_1, diffs_3, last_joltage} ->
      cond do
        joltage - last_joltage == 1 ->
          {diffs_1 + 1, diffs_3, joltage}

        joltage - last_joltage == 3 ->
          {diffs_1, diffs_3 + 1, joltage}
      end
    end)
  end

  def memoized_find_arrangements(jolts, current, memo) do
    case Agent.get(memo, &Map.get(&1, {jolts, current})) do
      nil ->
        result = find_arrangements(jolts, current, memo)
        Agent.update(memo, &Map.put(&1, {jolts, current}, result))
        result

      result ->
        result
    end
  end

  def find_arrangements([], _current, _memo), do: 1

  def find_arrangements(jolts, current, memo) do
    jolts
    |> Enum.slice(0..2)
    |> Enum.with_index()
    |> Enum.filter(fn {joltage, _index} -> joltage - current <= 3 end)
    |> Enum.map(fn {joltage, index} ->
      {joltage, Enum.slice(jolts, (index + 1)..-1)}
    end)
    |> Enum.map(fn {joltage, tail} ->
      memoized_find_arrangements(tail, joltage, memo)
    end)
    |> Enum.sum()
  end
end
