defmodule Skeleton.User do
  use Skeleton.Web, :model

  schema "users" do
    field :username,      :string
    field :password_hash, :string
    field :salt,          :string

    has_many :user_userrole_maps, Skeleton.UserUserroleMap, foreign_key: :user_id
    
    has_many :userroles, through: [ :user_userrole_maps, :userrole ]
    
  end

  @required_fields ~w(username)
  @optional_fields ~w()
  
  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ nil) do
    model
    |> cast( params, ~w(username), ~w(password_hash salt))
    |> validate_length( :username, 3..64)
  end

end

defmodule Skeleton.User.Helper do
  import Ecto.Query
  
  def roles_query_2( u ) do
    from user in Skeleton.User,
      where: user.id == ^u.id,
      preload: [:user_userrole_maps, user_userrole_maps: :userrole]
  end
  
  def roles_of_2( u ) do
    [ user ] = Skeleton.Repo.all roles_query_2( u )
    Enum.map( user.user_userrole_maps, fn(map) -> map.userrole.name end )
  end

  def roles_query_1( u ) do
    from user in Skeleton.User,      
      where: user.id == ^u.id,
      preload: [:userroles ]
  end

  def roles_of_1( user ) do
    [ user ] = Skeleton.Repo.all roles_query_1( user )
    Enum.map user.userroles, fn( userrole) -> userrole.name end
  end

  def roles_query_0( p_user ) do
    Skeleton.Userrole
    |> Ecto.Query.join( :inner, [ role ],      map  in assoc( role, :user_userrole_maps ) )
    |> Ecto.Query.join( :inner, [ role, map ], user in assoc( map,  :user ) )
    |> Ecto.Query.where( [role, map, user], user.id == ^p_user.id )
    |> Ecto.Query.select( [ role, map, user ], role.name )
  end

  def roles_of_0( p_user ) do
    Skeleton.Repo.all roles_query_0( p_user )
  end

  @doc """
  roles_of( user::%{ id: id::Int } ) :: List of role names

  Calls to roles_of_0( user ) internally. Interestingly, making three subsequent
  SELECTs (as roles_of_2 does) seems faster than doing a two single JOINs in
  Postgre on small data sets.
  
  For bigger setups (1000 users, 100 roles, 5000 role assignments), the JOIN is
  ~2x faster. So we're using it by default.

  TODO: Investigate on this as it seems strange.
  """
  def roles_of( user ) do roles_of_0( user ) end

  def get_by_username( username ) do
    query = Skeleton.User
    |> Ecto.Query.where( [user], user.username == ^username )
    |> Ecto.Query.limit( [user], 1 )
    Skeleton.Repo.all( query ) |> List.first
  end

  def make_password_hash( password ) do
    salt = Enum.map(1..8, fn(_) -> :random.uniform(256)-1 end ) |> List.to_string
    make_password_hash( password, salt )
  end

  def make_password_hash( password, salt ) do
    hash = :crypto.hmac(:sha256, password, salt ) |> :binary.bin_to_list |> List.to_string
    { salt, hash }
  end
  
  def verify_password( password, salt, password_hash ) do
    { _salt, hash } = make_password_hash( password, salt )
    hash == password_hash
  end


  @doc """
  Verifies a user's password. Returns true/false.
  """
  def verify_password( user, password ) do
    verify_password( password, user.salt, user.password_hash )

  end

  @doc """
  Generates a random salt and sets the password_hash accordingly
  """  
  
  @spec set_password( user::Skeleton.User.t, password::String.t ) :: Skeleton.User.t

  def set_password( user, password  ) do
    { salt, hash } = make_password_hash( password )
    %{ user | salt: salt, password_hash: hash}    
  end


end
