defmodule Hello2.Mixfile do
  use Mix.Project

  def project do
    [ app: :hello2,
      version: "0.0.1",
      elixir: "~> 1.0.0",
      elixirc_paths: ["lib", "web"],
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
        mod: { Hello2, [] },
        applications: [
            :phoenix,
            :cowboy,
            :logger,
            :porcelain
        ]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
        # web framework
        {:phoenix, "0.4.1"},
        # http server
        {:cowboy, "~> 1.0.0"},
        # django templates
        {:erlydtl, github: "erlydtl/erlydtl", branch: "stable"},
        # adapter erlydtl => phoenix
        {:phoenix_dtl, "~> 0.0.1"},
        # memcached driver
        {:mcd, github: "EchoTeam/mcd"},
        # postgres driver
        {:postgrex, ">= 0.0.0"},
        # ORM-like
        {:ecto,     ">= 0.0.0"},
        # communication with external programs
        {:porcelain, "~> 2.0"}
    ]
  end
end
