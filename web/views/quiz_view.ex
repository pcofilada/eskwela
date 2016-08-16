defmodule Eskwela.QuizView do
  use Eskwela.Web, :view
  use Eskwela.Web, :controller

  alias Eskwela.Repo
  alias Eskwela.QuizQuestion

  def count_correct_answer(quiz, subject) do
    count = Eskwela.QuizQuestion
    |> where([q], q.correct == true)
    |> where([q], q.quiz_id == ^quiz)
    |> where([q], q.subject_id == ^subject)
    |> Repo.all()
    |> Enum.count
  end

  def quiz_score(quiz, subject) do
    case List.first(subject.quiz_questions).user_choice do
      nil ->
        "Not yet started"
      _ ->
        "#{count_correct_answer(quiz.id, subject.id)} / #{Enum.count(subject.quiz_questions)}"
    end
  end
end
