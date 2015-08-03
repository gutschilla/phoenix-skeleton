defprotocol Plug.Authorization.Roles.Config do
#  @fallback_to_any true
  
  @doc "returns requires roles for current conn/opts"
  def required( opts )

  @doc "Extract userroles of from conn and return it"
  def get_userroles( conn )
end

# defimpl Plug.Authorization.Roles.Config, for: Any do
#   def required(_), do: []
#   def get_userroles(_), do: fn x -> [] end
# end

defimpl Plug.Authorization.Roles.Config, for: List do

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


defmodule Plug.Authorization.Roles do 

  alias Plug.Authorization.Roles.Config

  def init do
    []
  end
  
  def init( opts ) do
    opts 
  end

  def call( conn, opts ) do
    roles_of_user  = Config.get_userroles( opts ).( conn )
    roles_required = Config.required( opts )

    missing = Set.difference(
      Enum.into( roles_required, HashSet.new ), 
      Enum.into( roles_of_user,  HashSet.new )
    ) |> Set.to_list

    is_authorized = length( missing ) == 0

    assert_authorized conn, is_authorized, missing

  end

  def assert_authorized( conn, true, _ ) do
    conn
  end

  def assert_authorized( conn, false, missing ) do
    conn |>  
    Plug.Conn.send_resp( 403, "Access denied. Missing user roles " <> Enum.join( missing, ", ") )
  end

end

