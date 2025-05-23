defmodule Blog.MixProject do
  use Mix.Project

  def project do
    [
      app: :blog,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mdex, "~> 0.6.1"},
      {:nimble_publisher, "~> 1.1"},
      {:phoenix_live_view, "~> 1.0 "}
    ]
  end

  defp aliases do
    [
      "site.build": ["build"]
    ]
  end
end
