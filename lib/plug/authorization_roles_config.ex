defprotocol Plug.Authorization.Roles.Config do
  @vsn 1

  @moduledoc """
  Defines configuratuin for Plug.Authorization.Roles. 

  - Implement functions `required` to configure ways to 
    determine required roles to access a resource
  - Implement `get_userroles` to configure ways to extract 
    current connection's roles (most probaly via getting 
    the roles of the logged in user)
  """

#  @fallback_to_any true
  
  @doc "returns requires roles for current conn/opts"
  def required( opts )

  @doc "Extract userroles of from conn and return it"
  def get_userroles( conn )

end
