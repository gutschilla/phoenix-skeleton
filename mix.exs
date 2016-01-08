defmodule Skeleton.Mixfile do
  use Mix.Project

  def project do
    [app: :skeleton,
     version: "0.18.2",
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
        :postgrex,
        :plug_session_memcached
      ],
      included_applications: [
        :navigation_tree,
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
      {:phoenix, "~> 1.0.3"},
      {:phoenix_ecto, "~> 1.1"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.2"},
      {:phoenix_live_reload, "~> 1.0.1", only: :dev},
      {:cowboy, "~> 1.0"},
      {:navigation_tree, ">=0.4.4"},
      {:plug_session_memcached, ">=0.2.7"},
      {:mcd, github: "EchoTeam/mcd"},
      {:misc_random, github: "gutschilla/elixir-helper-random", tag: "0.2.3" },
      {:exrm, ">= 0.19.9"}
    ]
  end
end
