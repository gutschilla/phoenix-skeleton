defmodule Repo.Migrations.RenameUserrolesMap do
  use Ecto.Migration

  def up do
    "ALTER TABLE user_userroles_map  RENAME TO user_userrole_map;"
  end

  def down do
      "ALTER TABLE user_userrole_map  RENAME TO user_userroles_map;"
  end
end
