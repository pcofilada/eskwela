defmodule Eskwela.Auth do
  import Ecto.Changeset, only: [put_change: 3]
  import Plug.Conn
  import Phoenix.Controller

  alias Eskwela. { User, Repo }

  def init(options), do: options

  def call(conn, opts) do
    user_id = get_session(conn, :user_id)
    assign_current_user(conn, user_id)
  end

  def sign_up(changeset, repo) do
    changeset
    |> hashed_password()
    |> repo.insert()
  end

  def sign_in(params, repo) do
    User
    |> repo.get_by(username: params["username"])
    |> authenticate(params["password"])
  end

  def check_if_logged_in(conn, _) do
    case conn.assigns[:current_user] do
      nil ->
        conn
      _ ->
        check_role(conn, conn.assigns[:current_user].role)
    end
  end

  defp check_role(conn, role) do
    case role do
      "users" ->
          conn
          |> put_flash(:error, "You are already signedin.")
          |> redirect(to: "/quizzes")
      "admin" ->
          conn
          |> put_flash(:error, "You are already signedin.")
          |> redirect(to: "/levels")
    end
  end
  
  defp assign_current_user(%Plug.Conn{assigns: %{current_user: %User{}}} = conn, _user_id), do: conn
  defp assign_current_user(conn, user_id) do
    assign(conn, :current_user, user_id && Repo.get(User, user_id))
  end

  defp hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end

  defp authenticate(nil, password), do: :error
  defp authenticate(user, password) do
    Comeonin.Bcrypt.checkpw(password, user.password_hash)
    |> case do
      true -> {:ok, user}
      _    -> :error
    end
  end
end
