defmodule Skeleton.NavigationTree do

  # TODO: auto-gerenerate this as macro instead of having this boilerplate code

  # import NavigationTree.Node;
  alias NavigationTree.Node, as: Node;
  alias NavigationTree, as: SUPER;

  # here goes your actual Tree:
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

  def allowed_as_list( userroles ) do
    allowed_tree( userroles ) |> NavigationTree.as_list(0)
  end

  def allowed_for_user_id( user_id ) when is_nil( user_id ) do
    allowed_tree []
  end

  def allowed_for_user_id( user_id ) do
    roles = Skeleton.User.Helper.roles_of( Skeleton.Repo.get Skeleton.User, user_id )
    allowed_tree roles
  end

  def as_html( list ) when is_list( list ) do
    list = Enum.map list, &as_html/1
    Enum.join list, "\n"
  end

  def as_html( item ) when is_map( item) do
    case item do
        %{ ul_start: true } -> ~s(<ul tralls="dkjfhsdklfhsdkljfhsdkljh" class=\"#{ Enum.join( item.classes, " " ) }\">)
        %{ anchor:   true } -> ~s(<a href="#{ item.href }">#{ item.text }</a>)
        %{ li_start: true } -> ~s(<li class=\"#{ Enum.join( item.classes, " " ) }\">)
        %{ ul_stop:  true } -> ~s(</ul>)
        %{ li_stop:  true } -> ~s(</li>)
        %{ dropdown_toggle: true } -> ~s(<a href="#" class="dropdown-toggle " data-toggle="dropdown"><b class="caret"></b></a>)
      end
  end

  def as_html do
    as_list |> as_html
  end

  def as_html_for_user_id( user_id ) do
    allowed_for_user_id( user_id ) 
    |> NavigationTree.as_list( 0 )
    |> as_html
  end


end
