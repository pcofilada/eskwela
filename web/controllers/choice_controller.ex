defmodule Eskwela.ChoiceController do
  use Eskwela.Web, :controller
  import Eskwela.Redirect

  plug :put_layout, "admin.html"
  plug :user_logged_in?
  plug :is_admin?

  alias Eskwela.Question
  alias Eskwela.Choice

  def new(conn, %{"question_id" => question_id}) do
    question = Repo.get!(Question, question_id)
    changeset = question
      |> build_assoc(:choices) 
      |> Choice.changeset()
    render(conn, "new.html", changeset: changeset, question: question)
  end

  def create(conn, %{"question_id" => question_id, "choice" => choice_params}) do
    question = Repo.get!(Question, question_id)
    changeset = question
      |> build_assoc(:choices)
      |> Choice.changeset(choice_params)

    case Repo.insert(changeset) do
      {:ok, _choice} ->
        conn
        |> put_flash(:info, "Choice created successfully.")
        |> redirect(to: question_path(conn, :show, question))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, question: question)
    end
  end

  def edit(conn, %{"question_id" => question_id, "id" => id}) do
    question = Repo.get!(Question, question_id)
    choice = Repo.get!(Choice, id)
    changeset = Choice.changeset(choice)
    render(conn, "edit.html", choice: choice, question: question, changeset: changeset)
  end

  def update(conn, %{"question_id" => question_id, "id" => id, "choice" => choice_params}) do
    question = Repo.get!(Question, question_id)
    choice = Repo.get!(Choice, id)
    changeset = Choice.changeset(choice, choice_params)

    case Repo.update(changeset) do
      {:ok, choice} ->
        conn
        |> put_flash(:info, "Choice updated successfully.")
        |> redirect(to: question_path(conn, :show, question))
      {:error, changeset} ->
        render(conn, "edit.html", choice: choice, question: question, changeset: changeset)
    end
  end

  def delete(conn, %{"question_id" => question_id, "id" => id}) do
    question = Repo.get!(Question, question_id)
    choice = Repo.get!(Choice, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(choice)

    conn
    |> put_flash(:info, "Choice deleted successfully.")
    |> redirect(to: question_path(conn, :show, question))
  end

  def set_answer(conn, %{"question_id" => question_id, "choice_id" => choice_id}) do
    question = Repo.get!(Question, question_id)
    Ecto.Model.assoc(question, :choices) |> Repo.update_all(set: [correct_answer: false])
    choice = Repo.get!(Choice, choice_id)
    changeset = Choice.changeset(choice, %{"correct_answer" => true})

    case Repo.update(changeset) do
      {:ok, choice} ->
        conn
        |> put_flash(:info, "Choice set as correct answer successfully.")
        |> redirect(to: question_path(conn, :show, question))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Can't set as correct answer.")
        |> redirect(to: question_path(conn, :show, question))
    end

  end
end
