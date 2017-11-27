# Numexy

numexy is a library like Python's numpy. It is a library for matrix calculation.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `numexy` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:numexy, "~> 0.1.0"}
  ]
end
```

## Examples

```elixir
iex> x = Numexy.new([1,2,3])
%Array{array: [1, 2, 3], shape: {3, nil}}

iex> x = Numexy.new([[1,2,3],[1,2,3]])
%Array{array: [[1, 2, 3], [1, 2, 3]], shape: {2, 3}}
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/numexy](https://hexdocs.pm/numexy).

