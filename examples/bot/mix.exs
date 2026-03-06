defmodule Example.Mixfile do
  use Mix.Project

  def project do
    [
      app: :exirc_example,
      version: "0.0.1",
      elixir: "~> 1.17",
      deps: deps()
    ]
  end

  def application do
    [extra_applications: [:logger], mod: {Example, []}]
  end

  defp deps do
    [{:exirc_next, path: "../.."}]
  end
end
