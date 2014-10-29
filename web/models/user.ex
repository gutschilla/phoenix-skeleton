defmodule Skeleton2.User do
    use Ecto.Model

    validate user,

        username: present(),
        username: has_length(3..32),
        # do not allow unicode or special characters (except ".", "-" , _")
        username: has_format(~r/^[a-zA-Z0-9.\-_]+$/),

        password_hash: has_length(0..64),
        salt:          has_length(0..64)


    schema "users" do
        field :username,      :string
        field :password_hash, :string
        field :salt,          :string
        has_many :user_userrole_maps, Skeleton2.UserUserroleMap, foreign_key: :userrole_id
    end

end

defmodule Skeleton2.User.Helper do
    import Ecto.Query

    def get_query( user_id, :roles ) when is_number( user_id ) do
        query = Skeleton2.Userrole
        # join with map
        |> Ecto.Query.join( :inner, [role], map in role.user_userrole_maps  )
        # where user_id fits
        |> Ecto.Query.where( [_role, map], map.user_id == ^user_id )
        query
    end

    # USAGE:
    # user  = Repo.get( Skeleton2.User, 1 )
    # roles = Skeleton2.User.Helper.roles_of( user )
    def roles_of( user ) do
        get_query( user.id, :roles )
        |> Repo.all
        |> Enum.map( fn(userrole) -> userrole.name end )
    end

end
