defmodule Skeleton2.Helpers do

    def apply_defaults() do
        apply_defaults %{}
    end

    def apply_defaults( vars ) do
        if ! Dict.has_key? vars, :navigation do
            vars = Dict.put vars, :navigation, Skeleton2.Navigation.tree
        end
        if ! Dict.has_key? vars, :path do
            vars = Dict.put vars, :path, %{
                root:   Skeleton2.Router.Helpers.page_path(:index),
                static: Skeleton2.Router.Helpers.page_path(:index) <> "static/",
            }
        end
        vars
    end
    
end
