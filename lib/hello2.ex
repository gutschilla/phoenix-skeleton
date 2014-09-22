defmodule Hello2 do
    use Application
    
    # See http://elixir-lang.org/docs/stable/elixir/Application.html
    # for more information on OTP Applications
    def start(_type, _args) do
        import Supervisor.Spec, warn: false
      
        :ets.new(:session, [:named_table, :public, read_concurrency: true])

        #:ets.new(:subapps, [:named_table, :public, read_concurrency: true])
        #{:ok, memcached_PID } = :mcd.start_link()
        #:ets.insert(:subapps, {:memcached, memcached_PID})
        
        :mcd.start_link(:memcached_sessions, [] )
      
        children = [
          # Define workers and child supervisors to be supervised
          # worker(TestApp.Worker, [arg1, arg2, arg3])
        ]
      
        opts = [strategy: :one_for_one, name: Hello2.Supervisor]
        Supervisor.start_link(children, opts)
    end
end
