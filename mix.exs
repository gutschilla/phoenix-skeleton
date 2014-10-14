defmodule Skeleton2.Mixfile do
    use Mix.Project

    def project do
        [
            app: :skeleton2,
            version: "0.0.1",
            elixir: "~> 1.0",
            elixirc_paths: ["lib", "web"],
            compilers: [:phoenix] ++ Mix.compilers,
            deps: deps
        ]
    end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more
    def application do
        [
            mod: { Skeleton2, []},
            applications: [
                :phoenix,
                :cowboy,
                :logger,
                :porcelain,
            ]
        ]
    end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
    defp deps do
        [
        {:phoenix, "0.5.0"},   # web framework
        {:cowboy, "~> 1.0.0"}, # http server
        {:erlydtl, github: "erlydtl/erlydtl", branch: "stable"}, # django templates
        {:phoenix_dtl, "~> 0.0.1"},     # adapter erlydtl => phoenix
        {:mcd, github: "EchoTeam/mcd"}, # memcached driver
        {:postgrex, ">= 0.0.0"},        # postgres driver
        {:ecto,     ">= 0.0.0"},        # ORM look-alike
        {:pdf_generator, github: "gutschilla/elixir-pdf-generator", branch: "master" }, # simple PDF generator
        ]
    end
end
