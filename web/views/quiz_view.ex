defmodule Eskwela.QuizView do
  use Eskwela.Web, :view
  use Eskwela.Web, :controller

  alias Eskwela.Repo
  alias Eskwela.QuizQuestion
  alias Eskwela.Choice

  def count_correct_answer(quiz, subject) do
    count = QuizQuestion
    |> where([q], q.correct == true)
    |> where([q], q.quiz_id == ^quiz)
    |> where([q], q.subject_id == ^subject)
    |> Repo.all()
    |> Enum.count
  end

  def quiz_score(quiz, subject) do
    query = from qq in QuizQuestion, where: qq.quiz_id == ^quiz.id, where: qq.subject_id == ^subject.id, select: qq.user_choice
    user_choices = Repo.all(query)
    case Enum.member?(user_choices, nil) do
      true ->
        "Not yet started"
      false ->
        "#{count_correct_answer(quiz.id, subject.id)} / 20"
    end
  end

  def check_if_finished(conn, quiz, subject) do
    query = from qq in QuizQuestion, where: qq.quiz_id == ^quiz.id, where: qq.subject_id == ^subject.id, select: qq.user_choice
    user_choices = Repo.all(query)
    case Enum.member?(user_choices, nil) do
      true ->
        link "Start", to: quiz_start_path(conn, :start, quiz, subject), class: "btn btn-success btn-sm"
      false ->
        link "Preview", to: quiz_preview_path(conn, :preview, quiz, subject), class: "btn btn-info btn-sm"
    end
  end

  def user_choice(choice) do
    case choice do
      "0" ->
        "No answer"
      _ ->
        choice = Repo.get!(Choice, choice)
        choice.item
    end
  end

  def correct_answer(question) do
    answer = Choice
    |> where([q], q.question_id == ^question.id)
    |> where([q], q.correct_answer == true)
    |> Repo.all()
    |> List.first()
    answer.item
  end
end
