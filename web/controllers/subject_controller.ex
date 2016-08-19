defmodule Eskwela.SubjectController do
  use Eskwela.Web, :controller
  import Eskwela.Redirect

  plug :put_layout, "admin.html"
  plug :user_logged_in?
  plug :is_admin?

  alias Eskwela.Level
  alias Eskwela.Subject

  def new(conn, %{"level_id" => level_id}) do
    level = Repo.get!(Level, level_id)
    changeset = level
      |> build_assoc(:subjects)
      |> Subject.changeset()

    render(conn, "new.html", changeset: changeset, level: level)
  end

  def create(conn, %{"level_id" => level_id, "subject" => subject_params}) do
    level = Repo.get!(Level, level_id)
    changeset = level
      |> build_assoc(:subjects)
      |> Subject.changeset(subject_params)

    case Repo.insert(changeset) do
      {:ok, _subject} ->
        conn
        |> put_flash(:info, "Subject created successfully.")
        |> redirect(to: level_path(conn, :show, level))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, level: level)
    end
  end

  def edit(conn, %{"level_id" => level_id, "id" => id}) do
    level = Repo.get!(Level, level_id)
    subject = Repo.get!(Subject, id)
    changeset = Subject.changeset(subject)
    render(conn, "edit.html", subject: subject, level: level, changeset: changeset)
  end

  def update(conn, %{"level_id" => level_id, "id" => id, "subject" => subject_params}) do
    level = Repo.get!(Level, level_id)
    subject = Repo.get!(Subject, id)
    changeset = Subject.changeset(subject, subject_params)

    case Repo.update(changeset) do
      {:ok, subject} ->
        conn
        |> put_flash(:info, "Subject updated successfully.")
        |> redirect(to: level_path(conn, :show, level))
      {:error, changeset} ->
        render(conn, "edit.html", subject: subject, level: level, changeset: changeset)
    end
  end

  def delete(conn, %{"level_id" => level_id, "id" => id}) do
    level = Repo.get!(Level, level_id)
    subject = Repo.get!(Subject, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(subject)

    conn
    |> put_flash(:info, "Subject deleted successfully.")
    |> redirect(to: level_path(conn, :show, level))
  end
end
