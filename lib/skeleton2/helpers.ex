defmodule Skeleton2.Helpers do
    use Phoenix.Controller

    def apply_defaults( conn, vars ) do
        # default stash that depend on conn (e.g. user-specific stuff like navigation)
        user = get_session( conn, :user )
        |> Skeleton2.User.Helper.get

        apply_defaults( vars )
        |> Dict.put( :user, user )
        |> Dict.put( :navigation, Skeleton2.Navigation.allowed_as_list( user.roles ) )
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

end
