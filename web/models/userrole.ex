defmodule Skeleton.Userrole do
  use Skeleton.Web, :model

  schema "userroles" do
    field :name, :string
    has_many  :user_userrole_maps, Skeleton.UserUserroleMap
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ nil) do
    cast(model, params, ~w(name), ~w())
  end
end
