get_file = fn(name) ->
  Path.join([
    Application.app_dir(:flow_lightning, "priv"),
    name
  ])
end

measure = fn(fun) ->
  fun
  |> :timer.tc
  |> elem(0)
  |> Kernel./(1_000_000)
end

tests = [
  {"Enum: default"        , fn -> FlowLightning.run_with_enum() end},
  {"Stream: default"      , fn -> FlowLightning.run_with_stream() end},
  {"GenStage: default"    , fn -> FlowLightning.run() end},
  {"GenStage: words"      , fn -> FlowLightning.run(get_file.("words.txt")) end},
  {"GenStage: words by 2" , fn -> FlowLightning.run(get_file.("words_by_2.txt")) end},
  {"GenStage: words by 4" , fn -> FlowLightning.run(get_file.("words_by_4.txt")) end},
  {"GenStage: words by 8" , fn -> FlowLightning.run(get_file.("words_by_8.txt")) end},
  {"GenStage: words by 16", fn -> FlowLightning.run(get_file.("words_by_16.txt")) end}
]

tests
|> Enum.each(fn {title, fun} ->
  IO.puts "Running '#{title}' test..."
  IO.puts "Executed in #{measure.(fun)}"
end)
