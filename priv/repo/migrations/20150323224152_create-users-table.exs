defmodule :"Elixir.Skeleton.Repo.Migrations.Create-users-table" do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username,        :string,  size: 64
      add :password_hash,   :string,  size: 64
      add :salt,            :string,  size: 64
    end
  end
    
end
