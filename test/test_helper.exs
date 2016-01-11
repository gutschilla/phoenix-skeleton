ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Skeleton.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Skeleton.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Skeleton.Repo)

