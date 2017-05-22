defmodule FlowLightning.Snippet do
  def first do
    [1,2,3]
    |> Flow.from_enumerable()
    |> Flow.map(& &1 + 1)
    |> Enum.to_list
  end

  def second do
    File.stream!("/usr/share/dict/words")
    |> Flow.from_enumerable()
    |> Flow.flat_map(&String.split(&1, " "))
    |> Flow.partition()
    |> Flow.reduce(fn -> %{} end, fn word, acc ->
      Map.update(acc, word, 1, & &1 + 1)
    end)
    |> Enum.to_list()
  end

  def test do
    {:ok, stream} =
      "roses are red\nviolets are blue\n"
      |> StringIO.open()

    stream
    |> IO.binstream(:line)
    |> Flow.from_enumerable(max_demand: 1)
    |> Flow.flat_map(&String.split(&1, " "))
    |> Flow.reduce(fn -> %{} end, fn word, acc ->
      Map.update(acc, word, 1, & &1 + 1)
    end)
    |> Enum.to_list()
  end
end
