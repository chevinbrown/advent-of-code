defmodule Aoc.Day07 do
  @moduledoc """
  Luggage Processing
  """
  @behaviour Advent
  use Aoc.Boilerplate

  def setup() do
    stream_input()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&parse_rule/1)
    |> Enum.into(%{})
  end

  def p1(input) do
    graph =
      input
      |> build_graph()

    :digraph_utils.reaching_neighbours(["shiny gold"], graph)
    |> Enum.count()
  end

  def p2(input) do
    input
    |> build_graph()
    |> count_bags("shiny gold")
  end

  defp parse_rule(rule) do
    [container, contents] = String.split(rule, " bags contain ")
    {container, parse_contents(contents)}
  end

  defp parse_contents("no other bags."), do: %{}

  defp parse_contents(contents) do
    contents
    |> String.replace(~r/\sbags?\.?/, "")
    |> String.split(", ")
    |> Map.new(&content_tuple/1)
  end

  defp content_tuple(content) do
    [number, type] =
      content
      |> String.split(" ", parts: 2)

    {type, String.to_integer(number)}
  end

  defp build_graph(rules_map) do
    graph = :digraph.new()

    for {v, _} <- rules_map, do: :digraph.add_vertex(graph, v)

    for {from, contents} <- rules_map, {to, num} <- contents do
      :digraph.add_edge(graph, from, to, num)
    end

    graph
  end

  defp count_bags(graph, vertex) do
    graph
    |> :digraph.out_edges(vertex)
    |> Enum.reduce(1, fn e, sum ->
      {^e, _, vertex, num} = :digraph.edge(graph, e)
      sum + num * count_bags(graph, vertex)
    end)
  end
end
