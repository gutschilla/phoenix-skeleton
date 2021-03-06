defmodule Skeleton.Mixfile do
  use Mix.Project

  def project do
    [app: :skeleton,
     version: "0.19.2",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Skeleton, []},
      applications: [
        :phoenix,
        :cowboy,
        :logger,
        :gettext,
        :postgrex,
        :phoenix_ecto,
        :phoenix_html,
        :lager,
        :corman,
        :misc_random,
      ],
      included_applications: [
        :navigation_tree,
        :plug_session_memcached,
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.1.2"},
      {:phoenix_ecto, "~> 2.0"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.3"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.9"},
      {:cowboy, "~> 1.0"},
      {:navigation_tree, ">=0.4.4"},
      {:plug_session_memcached, ">=0.3.1"},
      {:mcd, github: "EchoTeam/mcd"},
      {:misc_random, ">=0.2.5" },
      {:exrm, ">= 1.0.0-rc7"}
    ]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"]]
  end
end
