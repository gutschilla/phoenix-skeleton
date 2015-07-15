defmodule Skeleton.UserUserroleMap do
  use Skeleton.Web, :model

  @primary_key false

  schema "user_userrole_maps" do
      belongs_to :user,     Skeleton.User,     foreign_key: :user_id,      references: :id
      belongs_to :userrole, Skeleton.Userrole, foreign_key: :userrole_id,  references: :id
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ nil) do
    cast(model, params, ~w(:userrole_id, :user_id), ~w())
  end
end
