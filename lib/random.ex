defmodule Random do

    def string( length ) do
        get_string( length )
    end

    def string() do
        get_string( 8 )
    end

    def get_string( length ) do
        alphabet
            =  "abcdefghijklmnopqrstuvwxyz"
            <> "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            <> "0123456789"
        alphabet_length = alphabet |> String.length
        1..length
        |> Enum.map_join fn(_) ->
            alphabet |> String.at :random.uniform( alphabet_length ) - 1
        end
    end

    def number() do
        get_number(8)
    end

    def number( length ) do
        get_number( length )
    end

    def get_number( length ) do
        1..length |> Enum.map_join fn(_) ->
            :random.uniform(10) - 1
        end
    end
end
