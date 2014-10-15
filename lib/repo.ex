defmodule Repo do
    use Ecto.Repo, adapter: Ecto.Adapters.Postgres

    def conf do
        # TODO: create something like My::DB::Hosts->host_for('postgres')
        parse_url "ecto://hello2_user:hello2_pass@192.168.0.240/hello2"
        # parse_url "ecto://hello2_user:hello2_pass@127.0.0.1/hello2"
    end

    def priv do
        app_dir(:skeleton2, "priv/repo")
    end
 end
