defmodule Mix.Tasks.Skeleton do
  defmodule Addrandomusers do
    use Mix.Task

    @moduledoc "add a thousand randdom users and a hundred random roles that randomly linked"

    @shortdoc "add lots of random users/roles"

    def run(_) do

      Skeleton.Repo.start_link

      users = 1..1000
      |> Enum.map fn( _num ) ->
        username = "U-" <> Misc.Random.string
        IO.puts username
        user = %Skeleton.User{ username: username }
        Skeleton.Repo.insert user
      end

      roles = 1..100
      |> Enum.map fn( _num ) ->
        rolename = "R-" <> Misc.Random.string
        IO.puts rolename
        role = %Skeleton.Userrole{ name: rolename }
        Skeleton.Repo.insert role
      end
      
      users
      |> Enum.each fn( user ) ->
        # link 1 to 10 roles to this user
        0..(:random.uniform 10)
        |> Enum.each fn( _num ) ->
          role = roles |> Enum.at :random.uniform( length( roles ) - 1 )
          try do
            map = %Skeleton.UserUserroleMap{ user_id: user.id, userrole_id: role.id }
            Skeleton.Repo.insert map
          rescue
            _e in Postgrex.Error -> nil 
          end
        end
      end

    end # /run
  end # /AddRandomUsers
end
