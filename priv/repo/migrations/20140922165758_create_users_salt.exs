defmodule Repo.Migrations.CreateUsersSalt do
  use Ecto.Migration

  def up do
    "ALTER TABLE users ADD COLUMN salt character varying(64);"
  end

  def down do
    "ALTER TABLE users DROP COLUMN salt;"
  end
end
