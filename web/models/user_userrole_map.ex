defmodule Skeleton2.UserUserroleMap do
    use Ecto.Model

    #validate user_userrole_map,
        #user_id:     present(),
        #userrole_id: present(),

    # the primary_key is [user_id, userrole_id].. but ecto doesn't support that, yet
    schema "user_userrole_map", primary_key: false do
        belongs_to :user,     Skeleton2.User,     foreign_key: :user_id
        belongs_to :userrole, Skeleton2.Userrole, foreign_key: :userrole_id
        #field :user_id,     :integer
        #field :userrole_id, :integer
    end
end
