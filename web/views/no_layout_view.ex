defmodule Hello2.NoLayoutView do
    def render( _template , conn ) do
        conn.inner
    end
end
