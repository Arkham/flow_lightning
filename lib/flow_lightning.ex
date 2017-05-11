defmodule FlowLightning do
  use Application

  @default_file "/usr/share/dict/words"

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = []
    opts = [strategy: :one_for_one, name: FlowLightning.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def run_with_enum(file \\ @default_file) do
    File.read!(file)
    |> String.split("\n")
    |> Enum.flat_map(&split_line/1)
    |> Enum.reduce(%{}, fn word, map ->
      Map.update(map, word, 1, & &1 + 1)
    end)
  end

  def run_with_stream(file \\ @default_file) do
    File.stream!(file)
    |> Stream.flat_map(&split_line/1)
    |> Enum.reduce(%{}, fn word, map ->
      Map.update(map, word, 1, & &1 + 1)
    end)
  end

  def run(file \\ @default_file) do
    File.stream!(file)
    |> Flow.from_enumerable()
    |> Flow.flat_map(&split_line/1)
    |> Flow.partition()
    |> Flow.reduce(fn -> %{} end, fn word, acc ->
      Map.update(acc, word, 1, & &1 + 1)
    end)
    |> Enum.to_list() 
  end

  defp split_line(line) do
    line
    |> String.trim_trailing()
    |> String.split()
  end
end
