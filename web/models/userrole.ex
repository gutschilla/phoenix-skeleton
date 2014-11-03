defmodule Skeleton2.Userrole do
    use Ecto.Model

    validate userrole,
        name: present(),
        name: has_length(1..64)

    schema "userroles" do
        field :name, :string
        has_many :user_userrole_maps, Skeleton2.UserUserroleMap, foreign_key: :userrole_id
    end
end
