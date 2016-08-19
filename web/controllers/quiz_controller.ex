defmodule Eskwela.QuizController do
  use Eskwela.Web, :controller
  import Eskwela.Redirect

  plug :put_layout, "user.html"
  plug :user_logged_in?
  plug :is_user?

  alias Eskwela.Quiz
  alias Eskwela.Level
  alias Eskwela.Subject
  alias Eskwela.Choice
  alias Eskwela.QuizQuestion

  def index(conn, _params) do
    user_id = get_session(conn, :user_id)
    quizzes = Eskwela.Quiz
    |> where([q], q.user_id == ^user_id)
    |> Eskwela.Repo.all
    |> Repo.preload(:level)
    
    render(conn, "index.html", quizzes: quizzes)
  end

  def new(conn, _params) do
    levels = Repo.all(Level)
    |> Enum.map(&{&1.name, &1.id})
    changeset = Quiz.changeset(%Quiz{})

    render(conn, "new.html", changeset: changeset, levels: levels)
  end

  def create(conn, %{"quiz" => quiz_params}) do
    user_id = get_session(conn, :user_id)
    levels = Repo.all(Level)
    |> Enum.map(&{&1.name, &1.id})
    changeset = Quiz.changeset(%Quiz{status: "active", user_id: user_id}, quiz_params)

    case Repo.insert(changeset) do
      {:ok, quiz} ->
        create_quiz_questions(quiz)
        conn
        |> put_flash(:info, "Quiz created successfully.")
        |> redirect(to: quiz_path(conn, :index))
      {:error, changset} ->
        render(conn, "new.html", changeset: changeset, levels: levels)
    end
  end

  def show(conn, %{"id" => id}) do
    quiz = Repo.get!(Quiz, id)
    |> Repo.preload(:quiz_questions)
    |> Repo.preload([level: [subjects: [:quiz_questions] ]])
    subject_query = from qq in QuizQuestion, where: qq.quiz_id == ^quiz.id, select: qq.subject_id
    subject_ids = Repo.all(subject_query)
    |> Enum.uniq()
    subjects_query = from s in Subject, where: s.id in  ^subject_ids, select: s
    subjects = Repo.all(subjects_query)

    render(conn, "show.html", quiz: quiz, subjects: subjects)
  end
  
  def start(conn, %{"quiz_id" => quiz_id, "id" => id}) do
    changeset = QuizQuestion.changeset(%QuizQuestion{})
    quiz = Repo.get!(Quiz, quiz_id)
    |> Repo.preload(:quiz_questions)
    subject = Repo.get!(Subject, id)
    quiz_questions = QuizQuestion
    |> where([q], q.quiz_id == ^quiz_id)
    |> where([q], q.subject_id == ^id)
    |> Repo.all
    |> Repo.preload(question: :choices)


    render(conn, "start.html", quiz: quiz, subject: subject, quiz_questions: quiz_questions, changeset: changeset)
  end

  def submit(conn, %{"quiz_id" => quiz_id, "quiz_question" => quiz_question}) do
    quiz = Repo.get!(Quiz, quiz_id)
    |> Repo.preload(:quiz_questions)
    Enum.each quiz_question, fn q ->
      choice = elem(q, 1)
      user_choice = String.to_integer(choice["choice"])
      qq = Repo.get!(QuizQuestion, String.to_integer(elem(q, 0)))
      |> Repo.preload(question: :choices)
      correct_answer = Choice
      |> where([c], c.question_id == ^qq.question.id)
      |> where([c], c.correct_answer == true)
      |> Repo.all
      cond do
        List.first(correct_answer).id == user_choice ->
          correct = true
        List.first(correct_answer).id != user_choice ->
          correct = false
      end
      changeset = QuizQuestion.changeset(qq, %{"user_choice" => choice["choice"], "correct" => correct})

      case Repo.update(changeset) do
        {:ok, quiz_question} ->
          conn
          |> put_flash(:info, "Quiz Finished.")
          |> redirect(to: quiz_path(conn, :show, quiz))
        {:error, changeset} ->
          conn
          |> put_flash(:error, "Something went wrong.")
          |> redirect(to: quiz_path(conn, :show, quiz))
      end
    end
  end

  def submit(conn, %{"quiz_id" => quiz_id}) do
    conn
    |> put_flash(:error, "You need to answer all questions.")
    |> redirect(to: conn.request_path)
  end

  def preview(conn, %{"quiz_id" => quiz_id, "id" => id}) do
    quiz = Repo.get!(Quiz, quiz_id)
    |> Repo.preload(:quiz_questions)
    subject = Repo.get!(Subject, id)
    quiz_questions = QuizQuestion
    |> where([q], q.quiz_id == ^quiz_id)
    |> where([q], q.subject_id == ^id)
    |> Repo.all
    |> Repo.preload(question: :choices)

    render(conn, "preview.html", quiz: quiz, subject: subject, quiz_questions: quiz_questions)
  end

  defp create_quiz_questions(quiz) do
    subjects = Subject
    |> where([s], s.level_id == ^quiz.level_id)
    |> Repo.all
    |> Repo.preload(questions: :choices)

    for subject <- subjects do
     questions = Enum.take_random(subject.questions, 20) 

     for question <- questions do
       quiz_question = %Eskwela.QuizQuestion{subject_id: subject.id, question_id: question.id, quiz_id: quiz.id}

       Eskwela.Repo.insert(quiz_question)
     end
    end
  end
end
