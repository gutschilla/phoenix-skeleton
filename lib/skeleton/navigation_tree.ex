defmodule Skeleton.Navigation do

  require NavigationTree.Loader
  alias NavigationTree.Node, as: Node

  NavigationTree.Loader.make_module(
    Tree,
    %Node{
        name: "Home",
        children: [
            %Node{
                name: "Login",
                url:  "/auth",
            },
            %Node{
                name: "Admin",
                roles: ["admin"],
                children: [
                    %Node{ name: "Users" },
                    %Node{ name: "Roles" },
                ]
            }
        ]
    },
    fn( user_id ) when is_integer( user_id ) ->
      Skeleton.User.Helper.roles_of( Skeleton.Repo.get Skeleton.User, user_id )
    end
  )

end
