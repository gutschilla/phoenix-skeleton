defmodule Skeleton4.Repo.Migrations.UserUserroleMapFkeys do
  use Ecto.Migration

  def up do
    execute """
      ALTER TABLE user_userrole_maps
        ADD FOREIGN KEY (user_id) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE;
    """
  end

  def down do
    execute """
      ALTER TABLE user_userrole_maps
        DROP CONSTRAINT user_userrole_maps_user_id_fkey;
    """
  end
  
end
