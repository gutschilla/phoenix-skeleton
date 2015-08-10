defimpl Plug.Authorization.Roles.Config, for: List do
  @moduledoc """
  implement list-style config (ad-hoc config) for 
  Plug.Authorization.Roles.Config

  ## Examples

    def MyApp.MyController do
      plug Plug.Authorization.Roles,
        # Access to MyApp.MyController requires admin and superuser userroles
        required: ["admin", "superuser"],
        # a functions that returns a list of userrole names
        get_userroles_fun: fn( conn ) -> 
          # this assumens that current user's roles are stores in session as key :userroles
          elem Plug.Conn.fetch_session( conn, :userroles ), 1
        end
    end
  """

  def required( opts ) do
    {:ok, required } = Keyword.fetch( opts, :required )
    required
  end
  
  def get_userroles( opts ) do
    {:ok, fun } = Keyword.fetch( opts, :get_userroles_fun )
    fun
  end
    
  def get_userroles_from_session( conn ) do
    user = Plug.Conn.get_session( conn, :user ) 
    case user do
      nil -> []
      %{ id: user_id } -> Skeleton.User.Helper.roles_of %{ id: user_id }
      _   -> throw( :invalid_user_session_format )
    end
    # roles_of_user = Skeleton.User.Helper.roles_of %{ id: user.id }
  end

end

defimpl Plug.Authorization.Roles.Config, for: Map do
 def required(      opts ), do: opts.required
 def get_userroles( opts ), do: opts.get_userroles
end
