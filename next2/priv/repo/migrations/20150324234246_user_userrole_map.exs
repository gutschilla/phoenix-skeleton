defmodule Skeleton4.Repo.Migrations.UserUserroleMap do
  use Ecto.Migration

  def change do
    create table( :user_userrole_maps, primary_key: false ) do
      add :user_id,     :integer
      add :userrole_id, :integer
    end
  
    # should be primary key
    # create index(:user_userrole_map, [:user_id, :userrole_id], unique: true )

  end
end
