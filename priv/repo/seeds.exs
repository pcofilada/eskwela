# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Eskwela.Repo.insert!(%Eskwela.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
questions = [
  %{item: "8 take away 3 = ?", choices: [
    %{item: "8", correct: false}, %{item: "11", correct: false}, %{item: "5", correct: true}
  ]},
  %{item: "9 take away 5 = ?", choices: [
    %{item: "5", correct: false}, %{item: "14", correct: false}, %{item: "4", correct: true}
  ]},
  %{item: "8 take away 6 = ?", choices: [
    %{item: "12", correct: false}, %{item: "14", correct: false}, %{item: "2", correct: true}
  ]},
  %{item: "8 - 1 = ?", choices: [
    %{item: "8", correct: false}, %{item: "9", correct: false}, %{item: "7", correct: true}
  ]},
  %{item: "9 - 4 = ?", choices: [
    %{item: "8", correct: false}, %{item: "13", correct: false}, %{item: "5", correct: true}
  ]},
  %{item: "8 - 8 = ?", choices: [
    %{item: "8", correct: false}, %{item: "16", correct: false}, %{item: "0", correct: true}
  ]},
  %{item: "There are 16 balls in a box. 9 of the balls are red. How many balls are not red?", choices: [
    %{item: "9 balls", correct: false}, %{item: "16 balls", correct: false}, %{item: "7 balls", correct: true}
  ]},
  %{item: "There are 8 cows and 12 horses at the farm. 5 horses ran away. How many horses were left?", choices: [
    %{item: "8 horses", correct: false}, %{item: "12 horses", correct: false}, %{item: "7 horses", correct: true}
  ]},
  %{item: "8 + 4 = ?", choices: [
    %{item: "8", correct: false}, %{item: "4", correct: false}, %{item: "12", correct: true}
  ]},
  %{item: "8 + 8 = ?", choices: [
    %{item: "8", correct: false}, %{item: "0", correct: false}, %{item: "16", correct: true}
  ]},
  %{item: "6 + 9 = ?", choices: [
    %{item: "9", correct: false}, %{item: "14", correct: false}, %{item: "15", correct: true}
  ]},
  %{item: "1 + 9 + 7 = ?", choices: [
    %{item: "13", correct: false}, %{item: "18", correct: false}, %{item: "17", correct: true}
  ]},
  %{item: "4 + 6 + 3 = ?", choices: [
    %{item: "12", correct: false}, %{item: "18", correct: false}, %{item: "13", correct: true}
  ]},
  %{item: "5 + 5 + 2 = ?", choices: [
    %{item: "10", correct: false}, %{item: "5", correct: false}, %{item: "12", correct: true}
  ]},
  %{item: "? + 4 = 7", choices: [
    %{item: "7", correct: false}, %{item: "5", correct: false}, %{item: "3", correct: true}
  ]},
  %{item: "1 + ? = 5", choices: [
    %{item: "5", correct: false}, %{item: "1", correct: false}, %{item: "4", correct: true}
  ]},
  %{item: "? + 6 = 9", choices: [
    %{item: "9", correct: false}, %{item: "6", correct: false}, %{item: "3", correct: true}
  ]},
  %{item: "4 + 3 + ? = 10", choices: [
    %{item: "10", correct: false}, %{item: "4", correct: false}, %{item: "3", correct: true}
  ]},
  %{item: "? + 3 + 5 = 9", choices: [
    %{item: "9", correct: false}, %{item: "0", correct: false}, %{item: "1", correct: true}
  ]},
  %{item: "2 + 4 + ? = 10", choices: [
    %{item: "10", correct: false}, %{item: "1", correct: false}, %{item: "4", correct: true}
  ]}
]
Eskwela.Repo.insert!(%Eskwela.User{first_name: "Eskwela", last_name: "Admin", password_hash: Comeonin.Bcrypt.hashpwsalt("password"), role: "admin", username: "admin"})
Eskwela.Repo.insert!(%Eskwela.Level{name: "Grade 1"})
Eskwela.Repo.insert!(%Eskwela.Subject{name: "Mathematics", level_id: 1})
Enum.each questions, fn q ->
  question = Eskwela.Repo.insert!(%Eskwela.Question{item: q[:item], subject_id: 1})
  Enum.each q[:choices], fn c ->
    Eskwela.Repo.insert!(%Eskwela.Choice{item: c[:item], question_id: question.id, correct_answer: c[:correct]})
  end
end
