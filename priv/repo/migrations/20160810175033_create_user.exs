defmodule Eskwela.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :first_name, :string
      add :last_name, :string
      add :password_hash, :string
      add :role, :string

      timestamps()
    end

  end
end
