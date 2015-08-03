defmodule Skeleton.Authorization.Helper do
  def get_userroles_fun( conn ) do
   user = Plug.Conn.get_session( conn, :user ) 
   case user do
     nil -> []
     %{ id: user_id } -> Skeleton.User.Helper.roles_of %{ id: user_id }
     _   -> throw( :invalid_user_session_format )
   end
  end
end

defmodule Skeleton.Authorization do
  defstruct required: [], get_userroles: &Skeleton.Authorization.Helper.get_userroles_fun/1
end

defimpl Plug.Authorization.Roles.Config, for: Skeleton.Authorization do
 def required(      opts ), do: opts.required
 def get_userroles( opts ), do: opts.get_userroles
end

