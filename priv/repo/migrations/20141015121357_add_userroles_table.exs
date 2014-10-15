defmodule Repo.Migrations.AddUserrolesTable do
  use Ecto.Migration

  def up do
    """
        CREATE TABLE public.userroles
        (
           id serial,
           name character varying,
           PRIMARY KEY (id),
           UNIQUE (name)
        )
        WITH (
          OIDS = FALSE
        )
        ;
    """
  end

  def down do
    "DROP TABLE public.userroles;"
  end
end
