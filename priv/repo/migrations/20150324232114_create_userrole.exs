defmodule Skeleton.Repo.Migrations.CreateUserrole do
  use Ecto.Migration

  def change do
    create table(:userroles) do
      add :name, :string
   end
  end
end
