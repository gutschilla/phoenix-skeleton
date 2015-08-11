defmodule Skeleton.Mixfile do
  use Mix.Project

  def project do
    [app: :skeleton,
     version: "0.16.0",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: {Skeleton, []},
      applications: [
        :phoenix, 
        :phoenix_html, 
        :cowboy, 
        :logger,
        :phoenix_ecto, 
        :postgrex
      ]
    ]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "~> 0.16"},
      {:phoenix_ecto, "~> 0.9"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.0"},
      {:phoenix_live_reload, "~> 0.6", only: :dev},
      {:cowboy, "~> 1.0"},
      {:navigation_tree, ">=0.3.2"},
      {:misc_random, github: "gutschilla/elixir-helper-random", branch: "master" },
      {:exrm, ">=0.18.5"}
   ]
  end
end
