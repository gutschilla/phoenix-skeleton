defmodule Repo.Migrations.AlterUsersUniqueUsername do
  use Ecto.Migration

  def up do
    "ALTER TABLE users ADD CONSTRAINT users_username_key UNIQUE (username);"
  end

  def down do
    "ALTER TABLE users DROP CONSTRAINT users_username_key;"
  end
end
