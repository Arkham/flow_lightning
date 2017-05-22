# FlowLightning

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `flow_lightning` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:flow_lightning, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/flow_lightning](https://hexdocs.pm/flow_lightning).

## How to run

First create the data

`cd /priv && bash generate_data.sh && cd ..`

Then install the deps and run iex

`mix deps.get && iex -S mix`

Now just run

`FlowLightning.run("words_by_16.txt")`
