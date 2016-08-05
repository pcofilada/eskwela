defmodule Eskwela.LevelController do
  use Eskwela.Web, :controller

  alias Eskwela.Level

  def index(conn, _params) do
    levels = Repo.all(Level)
    render(conn, "index.html", levels: levels)
  end

  def new(conn, _params) do
    changeset = Level.changeset(%Level{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"level" => level_params}) do
    changeset = Level.changeset(%Level{}, level_params)

    case Repo.insert(changeset) do
      {:ok, _level} ->
        conn
        |> put_flash(:info, "Level created successfully.")
        |> redirect(to: level_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    level = Repo.get!(Level, id)
    |> Repo.preload([:subjects])

    render(conn, "show.html", level: level)
  end

  def edit(conn, %{"id" => id}) do
    level = Repo.get!(Level, id)
    changeset = Level.changeset(level)
    render(conn, "edit.html", level: level, changeset: changeset)
  end

  def update(conn, %{"id" => id, "level" => level_params}) do
    level = Repo.get!(Level, id)
    changeset = Level.changeset(level, level_params)

    case Repo.update(changeset) do
      {:ok, level} ->
        conn
        |> put_flash(:info, "Level updated successfully.")
        |> redirect(to: level_path(conn, :show, level))
      {:error, changeset} ->
        render(conn, "edit.html", level: level, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    level = Repo.get!(Level, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(level)

    conn
    |> put_flash(:info, "Level deleted successfully.")
    |> redirect(to: level_path(conn, :index))
  end
end
