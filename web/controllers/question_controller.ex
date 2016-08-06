defmodule Eskwela.QuestionController do
  use Eskwela.Web, :controller

  alias Eskwela.Question
  alias Eskwela.Level

  def index(conn, _params) do
    questions = Repo.all(from question in Question, preload: [subject: :level])
    render(conn, "index.html", questions: questions)
  end

  def new(conn, _params) do
    levels = Repo.all(from l in Level, preload: [:subjects], order_by: l.id)
    changeset = Question.changeset(%Question{})
    render(conn, "new.html", changeset: changeset, levels: levels)
  end

  def create(conn, %{"question" => question_params}) do
    levels = Repo.all(from l in Level, preload: [:subjects], order_by: l.id)
    changeset = Question.changeset(%Question{}, question_params)

    case Repo.insert(changeset) do
      {:ok, _question} ->
        conn
        |> put_flash(:info, "Question created successfully.")
        |> redirect(to: question_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, levels: levels)
    end
  end

  def show(conn, %{"id" => id}) do
    question = Repo.get!(Question, id)
    |> Repo.preload([subject: :level])
    render(conn, "show.html", question: question)
  end

  def edit(conn, %{"id" => id}) do
    levels = Repo.all(from l in Level, preload: [:subjects], order_by: l.id)
    question = Repo.get!(Question, id)
    changeset = Question.changeset(question)
    render(conn, "edit.html", question: question, changeset: changeset, levels: levels)
  end

  def update(conn, %{"id" => id, "question" => question_params}) do
    levels = Repo.all(from l in Level, preload: [:subjects], order_by: l.id)
    question = Repo.get!(Question, id)
    changeset = Question.changeset(question, question_params)

    case Repo.update(changeset) do
      {:ok, question} ->
        conn
        |> put_flash(:info, "Question updated successfully.")
        |> redirect(to: question_path(conn, :show, question))
      {:error, changeset} ->
        render(conn, "edit.html", question: question, changeset: changeset, levels: levels)
    end
  end

  def delete(conn, %{"id" => id}) do
    question = Repo.get!(Question, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(question)

    conn
    |> put_flash(:info, "Question deleted successfully.")
    |> redirect(to: question_path(conn, :index))
  end
end
