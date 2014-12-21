defmodule Skeleton3.Navigation do

  # TODO: auto-gerenerate this as macro instead of having this boilerplate code

  import NavigationTree.Node;
  alias NavigationTree.Node, as: Node;
  alias NavigationTree, as: SUPER;

  # here goes your actual Tree:
  def config do
      %Node{
          name: "Skeleton3-Home",
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

  def tree do
    SUPER.thaw config
  end
  
  def allowed_tree( userroles ) do
    SUPER.allowed_tree( userroles, tree() )
  end
  
  def as_list do
      # using as_list2, now
      SUPER.as_list tree, 0
  end

end