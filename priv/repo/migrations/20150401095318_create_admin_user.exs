defmodule Skeleton.Repo.Migrations.CreateAdminUser do
  use Ecto.Migration

  def up do
    # password is "admin"
    {salt, hash} =  Skeleton.User.Helper.make_password_hash "admin"
    execute """
      INSERT INTO users ( id, username, password_hash, salt )
      VALUES ( 1, 'admin', '#{hash}', '#{salt}' );
    """
    execute """
      INSERT INTO userroles ( id, name)                      VALUES ( 1, 'admin' );
    """
    execute """
      INSERT INTO user_userrole_maps ( user_id, userrole_id) VALUES ( 1, 1 );
    """
  end

  def down do
    execute """
      DELETE FROM users     WHERE id = 1;
    """
    execute """
      DELETE FROM userroles WHERE id = 1;
    """
  end

end
