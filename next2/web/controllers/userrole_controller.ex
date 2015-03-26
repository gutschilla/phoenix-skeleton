defmodule Skeleton4.UserroleController do
  use Skeleton4.Web, :controller

  alias Skeleton4.Userrole

  plug :scrub_params, "userrole" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    userroles = Repo.all(Userrole)
    render conn, "index.html", userroles: userroles
  end

  def new(conn, _params) do
    changeset = Userrole.changeset(%Userrole{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"userrole" => userrole_params}) do
    changeset = Userrole.changeset(%Userrole{}, userrole_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Userrole created succesfully.")
      |> redirect(to: userrole_path(conn, :index))
    else
      render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => id}) do
    userrole = Repo.get(Userrole, id)
    render conn, "show.html", userrole: userrole
  end

  def edit(conn, %{"id" => id}) do
    userrole = Repo.get(Userrole, id)
    changeset = Userrole.changeset(userrole)
    render conn, "edit.html", userrole: userrole, changeset: changeset
  end

  def update(conn, %{"id" => id, "userrole" => userrole_params}) do
    userrole = Repo.get(Userrole, id)
    changeset = Userrole.changeset(userrole, userrole_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Userrole updated succesfully.")
      |> redirect(to: userrole_path(conn, :index))
    else
      render conn, "edit.html", userrole: userrole, changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    userrole = Repo.get(Userrole, id)
    Repo.delete(userrole)

    conn
    |> put_flash(:info, "Userrole deleted succesfully.")
    |> redirect(to: userrole_path(conn, :index))
  end
end
