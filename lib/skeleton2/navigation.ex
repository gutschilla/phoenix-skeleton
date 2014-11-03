defmodule Skeleton2.NavigationNode do
    defstruct \
        name: "",
        url:  nil,
        children: [],
        roles: []
end

defmodule Skeleton2.Navigation do

    alias Skeleton2.NavigationNode, as: Node

    def config() do
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

    def tree() do
        thaw config
    end

    def thaw( node ) do
        # note that root node's url is "/", but setting parent_url to ""
        # to avoid double slashes in front of other urls
        thaw node, "", []
    end

    def thaw( node, parent_url, parent_roles ) do

        url = cond do
            node.url          -> node.url
            parent_url == ""  -> "/"
            parent_url == "/" -> ( "/" <> safe_name( node.name ) )
            true              -> ( parent_url <> "/" <> safe_name( node.name ) )
        end

        roles = parent_roles ++ node.roles

        children = Enum.map(
            node.children,
            fn( child ) ->
                thaw( child, url, roles )
            end
        )

        %{ node |
            url:      url,
            roles:    roles,
            children: children
        }

    end

    def safe_name( name ) do
        String.downcase( name )
    end

    def allowed_tree( userroles ) do
        allowed_tree( userroles, tree() )
    end

    def allowed_tree( userroles, node ) do
        %Node{ node |
            children: Enum.filter(
                node.children,
                fn( child ) ->
                    needed = Enum.into child.roles, HashSet.new
                    having = Enum.into userroles,   HashSet.new
                    # needed minus having shall be empty
                    result = Set.difference( needed, having )
                    Set.size( result ) == 0
                end
            )
        }
    end

    def as_simple_hash( node, level ) do
        %{
            name:  node.name,
            url:   node.url,
            level: level,
            has_children: case length node.children do 0 -> false; _ -> true end
        }
    end

    def allowed_as_list( userroles ) do
        as_list allowed_tree( userroles, tree() )
    end

    def as_list() do
        as_list tree
    end
    def as_list( node ) do
        as_list( node, 0 )
    end
    def as_list( node = %Node{ children: [] }, level ) do
        [ as_simple_hash( node, level ) ]
    end
    def as_list( node, level ) do
        List.flatten([
            as_simple_hash( node, level ),
            %{ up: true, level: level },
            Enum.map(
                node.children,
                fn(n) -> as_list( n, level + 1 ) end
            ),
            %{ down: true, level: level },
        ])
    end

end
