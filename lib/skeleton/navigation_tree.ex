defmodule Skeleton.Navigation do

  alias NavigationTree.Node, as: Node

  def config do
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
    }
  end

end
