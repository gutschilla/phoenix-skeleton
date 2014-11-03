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
        has_many :user_userrole_maps, Skeleton2.UserUserroleMap, foreign_key: :user_id
    end

end

defmodule Skeleton2.User.Helper do
    import Ecto.Query

    def auth_query( user, pass ) do
        Skeleton2.User
        |> Ecto.Query.where(
            [user],
            user.username == ^user
            and user.password_hash == ^pass
        )
    end

    def auth( user, pass ) do
        case auth_query( user, pass ) |> Repo.all do
            [ user ] -> { :ok, user }
            []       -> { :not_found }
        end
    end

    def roles_query do
        Skeleton2.Userrole
        # join with map
        |> Ecto.Query.join( :inner, [role], map in role.user_userrole_maps  )
        # join with users
        |> Ecto.Query.join( :inner, [role, map ], user in map.user  )
    end

    def roles_query( u ) do
        roles_query
        |> Ecto.Query.where(
            [ role, map, user ],
            user.id == ^u.id
        )
    end

    def roles( user ) do
        roles_query( user )
        |> Repo.all
        |> Enum.map( fn(r) -> r.name end )
    end

    def get( nil ) do
        %{
            id:       0,
            username: "",
            roles:    []
        }
    end
    def get( user ) do
        %{
            id:       user.id,
            username: user.username,
            roles:    roles( user )
        }
    end

end
