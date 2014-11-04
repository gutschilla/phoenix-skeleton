defmodule Skeleton2.Helpers do

    @moduledoc "Convenience methods"

    use Phoenix.Controller

    @doc """
        merges vars with current user (might be empty), the navigation-as-list and
        path.root, path.static

        returns merges vars
    """
    def apply_defaults( conn, vars ) do
        # default stash that depend on conn (e.g. user-specific stuff like navigation)
        user = get_session( conn, :user )
        |> Skeleton2.User.Helper.get

        apply_defaults( vars )
        |> Dict.put( :user, user )
        |> Dict.put( :navigation, tl( Skeleton2.Navigation.allowed_as_list( user.roles ) ) )
    end


    def apply_defaults( vars ) do
        # default stash that doesn't depend on conn
        if ! Dict.has_key? vars, :path do
            vars = Dict.put vars, :path, %{
                root:   Skeleton2.Router.Helpers.page_path(:index),
                static: Skeleton2.Router.Helpers.page_path(:index) <> "static/",
            }
        end
        vars
    end

    @doc "Returns true when request headers 'accept' or 'content-type' look like there's a json request."
    def json_request?( conn ) do
        {"accept",       accept       } = List.keyfind( conn.req_headers, "accept", 0 )
        {"content-type", content_type } = List.keyfind( conn.req_headers, "content-type", 0 )
        String.contains?( accept, "application/json") || String.contains?( content_type, "application/json")
    end

end
