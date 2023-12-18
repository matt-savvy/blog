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
      {:makeup_diff, "~> 0.1"},
      {:makeup_eex, "~> 0.1"},
      {:makeup_elixir, "~> 0.16"},
      {:makeup_html, "~> 0.1"},
      {:makeup_js, "~> 0.1"},
      {:makeup_json, "~> 0.1"},
      {:mdex, "~> 0.1"},
      {:nimble_publisher, "~> 1.0"},
      {:phoenix_live_view, "~> 0.18"}
    ]
  end

  defp aliases do
    [
      "site.build": ["build"]
    ]
  end
end
