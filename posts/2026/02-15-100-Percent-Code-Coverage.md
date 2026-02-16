%{
  title: "100 Percent Code Coverage Is Not as Good as You Think",
  author: "Matt",
  tags: ~w(software-development AI LLM elixir),
  description: "Why 100% code coverage is a misleading metric and a false sense of security."
}
---

When I see people talk about code coverage, there are usually caveats that you don't need to worry about 100% coverage.
Some argue that it ends up being a victim of Goodhart's Law[^1], others say that you get diminishing returns.
Some will say that full code coverage is just a by-product of the proper development process, which should be your focus.
Others will point out that some things just don't need test coverage.
"Be pragmatic!", they'll say.

[^1]: ["When a measure becomes a target, it ceases to be a good measure."](https://en.wikipedia.org/wiki/Goodhart%27s_law)

But lately, since AI agents have become more common, I do see people starting to shoot for that perfect 100%.
Some feel that since they can just throw AI at it, they might as well ask for it.
Others think of it as a hedge against the unexpected things their agent might do, that it's just the kind of guardrails you need in this kind of workflow.

There's a fundamental point that's missed here.

## Test Coverage Says Nothing About The Quality Of Your Tests

Your tests are there to confirm some expectations.
Ideally, you have a good idea what this should be when you are writing your tests, and that's what your tests assert on.

But you can also have tests that don't assert on the right behavior and still end up with a perfect coverage score.
You can also have tests that confirm the right behavior without actually testing all the scenarios you need.

And when you end up here, you're actually worse off because it gives a false sense of security about your test suite.
You make some changes, your test suite is all green, and it gives you the confidence you need to push a bug right into production.

## An Example

Let's start with a simple Elixir module that creates a new `Payload` from some `data` and accepts some optional options.

```elixir
defmodule MyProject.Payload do
  defstruct [:id, :value]

  def new(data, opts \\ [field: :value]) do
    value = data[opts[:field]]

    %__MODULE__{
      id: id(),
      value: value
    }
  end

  defp id do
    System.unique_integer([:monotonic, :positive])
  end
end
```

Let's add a test with and without the options.

```elixir
describe "new/2" do
  test "uses value from input by default" do
    input = %{ value: 10 }
    assert %Payload{value: 10} = Payload.new(input)
  end

  test "allows opts to set field" do
    input = %{ input_value: 10 }
    opts = [field: :input_value]
    assert %Payload{value: 10} = Payload.new(input, opts)
  end
```

We'll run our tests with `mix test --cover` and confirm that we've covered everything.

```sh
Generating cover results ...

| Percentage | Module            |
|------------|-------------------|
|    100.00% | MyProject.Payload |
|------------|-------------------|
|    100.00% | Total             |
```

So far so good.
Now let's say we want to add some more functionality; when given an option `:double` set to `true`, the `value` should be doubled.
Easy enough:

```elixir
  def new(data, opts \\ [field: :value]) do
    value = data[opts[:field]]

+   value =
+     case opts[:double] do
+       true -> value * 2
+       _else -> value
+     end

    %__MODULE__{
      id: id(),
      value: value
    }
  end
```

This drops us down to 80% coverage, let's fix that.

```elixir
test "allows opts to apply double" do
  input = %{input_value: 10}
  opts = [field: :input_value, double: true]
  assert %Payload{value: 20} = Payload.new(input, opts)
end
```

```
$ mix test --cover

| Percentage | Module            |
|------------|-------------------|
|    100.00% | MyProject.Payload |
|------------|-------------------|
|    100.00% | Total             |
```

Okay, we're back at 100%, so we feel good about our changes.
But we shouldn't, because we've introduced a bug (did you see it?).

As soon as we use this in our app, things start to go wrong.
First, when we only pass `double: false`, our `value` ends up being `nil`.

```elixir
iex(1)> Payload.new(%{ value: 10 }, double: false)
%Payload{id: 1, value: nil}
```

But also, if we use this code with `double: true` but without the `:field` option, it just crashes.
```elixir
iex(2)> Payload.new(%{ value: 10 }, double: true)
** (ArithmeticError) bad argument in arithmetic expression: nil * 2
```

## 100% Test Coverage, 0% Assertion Coverage

What's worse is that we can actually get all the way to 100% code coverage *without even asserting anything*.
Let's take our above tests and remove the `assert`s.

```elixir
test "uses value from input by default" do
  input = %{value: 100}
  Payload.new(input)
end

test "allows opts to set field" do
  input = %{input_value: 10}
  opts = [field: :input_value]
  Payload.new(input, opts)
end

test "allows opts to apply double" do
  input = %{input_value: 10}
  opts = [field: :input_value, double: true]
  Payload.new(input, opts)
end
```

Our tests now prove exactly one thing: that this code won't crash under these exact circumstances.
Is it better than nothing?
Sure.
Should it give you confidence in your test suite?
Absolutely not.

## Why This Matters In The Age of AI

If you don't internalize this lesson, if you don't fully understand why 100% test coverage doesn't prove anything about how well tested your code is, you're going to be operating from a broken set of assumptions.

If you don't know what your code is supposed to do, you can't know if your tests are any good.
If you don't know if your tests are any good, you don't know if you should have any confidence when seeing that all tests are passing.

And if you think that using AI to get to 100% coverage is going to give you robust software, good luck.
You're going to need it.
