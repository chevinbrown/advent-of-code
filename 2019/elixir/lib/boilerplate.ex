defmodule Aoc.Boilerplate do
  defmacro __using__(_opts) do
    quote do
      def input_file(),
        do: Path.join([Application.app_dir(:aoc, "priv"), "#{module_name()}.in"])

      def stream_input() do
        input_file()
        |> File.stream!()
      end

      def integer_stream() do
        stream_input()
        |> Stream.map(&String.trim(&1))
        |> Stream.map(&String.to_integer(&1))
      end

      def read_input() do
        input_file()
        |> File.read!()
      end

      defp module_name() do
        __MODULE__
        |> to_string
        |> String.split(".")
        |> List.last()
        |> String.downcase()
      end
    end
  end
end
