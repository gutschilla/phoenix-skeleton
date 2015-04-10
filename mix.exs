defmodule Skeleton4.Mixfile do
  use Mix.Project

  def project do
    [app: :skeleton4,
     version: "0.0.1",
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
      mod: {Skeleton4, []},
      applications: [
        :phoenix, 
        :cowboy, 
        :logger, 
        :ecto,
        :plug_session_memcached 
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
      {:phoenix, "~> 0.11"},
      {:phoenix_ecto, "~> 0.3"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_live_reload, "~> 0.3"},
      {:cowboy, "~> 1.0"},
      {:plug_session_memcached, github: "gutschilla/plug-session-memcached", branch: "master" },
      {:phoenix_skeleton_deps_umbrella, github: "gutschilla/phoenix_skeleton_deps_umbrella", branch: "master" },
      {:misc_random, github: "gutschilla/elixir-helper-random", branch: "master" }
    ]
  end
end
