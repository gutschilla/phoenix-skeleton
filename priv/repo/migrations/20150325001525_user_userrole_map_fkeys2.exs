defmodule Skeleton.Repo.Migrations.UserUserroleMapFkeys2 do
  use Ecto.Migration

  def up do
    execute """
      ALTER TABLE user_userrole_maps
        ADD FOREIGN KEY (userrole_id) REFERENCES userroles (id) ON UPDATE CASCADE ON DELETE CASCADE;
    """
  end

  def down do
    execute """
      ALTER TABLE user_userrole_maps
        DROP CONSTRAINT user_userrole_maps_userrole_id_fkey;
    """
  end

end
