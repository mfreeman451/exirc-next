defmodule ExIRC.Mixfile do
  use Mix.Project

  def project do
    [
      app: :exirc_next,
      version: "3.0.2",
      elixir: "~> 1.17",
      description: "A modern IRC client library for Elixir. Fork of exirc, actively maintained.",
      package: package(),
      source_url: "https://github.com/mfreeman451/exirc",
      homepage_url: "https://github.com/mfreeman451/exirc",
      docs: [
        main: "ExIRC",
        extras: ["README.md", "CHANGELOG.md"]
      ],
      test_coverage: [tool: ExCoveralls],
      dialyzer: [
        plt_add_apps: [:ex_unit]
      ],
      deps: deps()
    ]
  end

  def cli do
    [
      preferred_envs: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.html": :test,
        "coveralls.post": :test
      ]
    ]
  end

  def application do
    [mod: {ExIRC.App, []}, extra_applications: [:logger, :ssl, :crypto, :inets]]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE", "CHANGELOG.md"],
      maintainers: ["Matt Freeman"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/mfreeman451/exirc"
      }
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.35", only: :dev, runtime: false},
      {:excoveralls, "~> 0.18", only: :test},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:mix_audit, "~> 2.1", only: [:dev, :test], runtime: false},
      {:sobelow, "~> 0.13", only: [:dev, :test], runtime: false}
    ]
  end
end
