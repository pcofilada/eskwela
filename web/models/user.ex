defmodule Eskwela.User do
  use Eskwela.Web, :model

  schema "users" do
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :role, :string
    has_many :quizzes, Eskwela.Quiz

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :first_name, :last_name, :password, :role])
    |> validate_required([:username, :first_name, :last_name, :password])
    |> update_change(:username, &String.downcase/1)
    |> unique_constraint(:username)
  end
end
