defmodule Repo.Migrations.AddUserUserrolesMap do
  use Ecto.Migration

  def up do
    """
    CREATE TABLE public.user_userroles_map
    (
       user_id integer NOT NULL,
       userrole_id integer NOT NULL,
       PRIMARY KEY (user_id, userrole_id),
       FOREIGN KEY (user_id) REFERENCES users (id) ON UPDATE CASCADE ON DELETE CASCADE,
       FOREIGN KEY (userrole_id) REFERENCES userroles (id) ON UPDATE CASCADE ON DELETE CASCADE
    )
    WITH (
      OIDS = FALSE
    )
    ;
    """
  end

  def down do
    "DROP TABLE public.user_userroles_map;"
  end
end
