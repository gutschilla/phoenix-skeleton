defmodule Skeleton.Repo.Migrations.UserUserroleMapPkey do
  use Ecto.Migration

  def up do
    execute """
    ALTER TABLE user_userrole_maps
      ADD PRIMARY KEY (user_id, userrole_id);
    """
  end

  def down do
    execute """
      ALTER TABLE user_userrole_maps
        DROP CONSTRAINT user_userrole_maps_pkey;
    """
  end

end
