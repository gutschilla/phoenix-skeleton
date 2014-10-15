defmodule Skeleton2 do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # TODO: make an app
    :mcd.start_link(:memcached_sessions, [] )

    children = [
      # Define workers and child supervisors to be supervised
      # worker(Skeleton2.Worker, [arg1, arg2, arg3])
      worker( Repo, [] )
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Skeleton2.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
