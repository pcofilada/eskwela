defmodule Eskwela.Repo.Migrations.CreateLevel do
  use Ecto.Migration

  def change do
    create table(:levels) do
      add :name, :string

      timestamps()
    end

  end
end
