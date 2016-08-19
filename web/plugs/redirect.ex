defmodule Eskwela.Redirect do
  import Plug.Conn
  import Phoenix.Controller

  def user_logged_in?(conn, _) do
    case conn.assigns[:current_user] do
      nil ->
        conn
        |> put_flash(:error, "You need to sign in or sign up before continuing.")
        |> redirect(to: "/sign_in")
      _ ->
        conn
    end
  end

  def is_admin?(conn, _) do
    case conn.assigns[:current_user].role do
      "users" ->
        conn
        |> send_resp(401, "You are not authorized to access this page.")
      "admin" ->
        conn
    end
  end

  def is_user?(conn, _) do
    case conn.assigns[:current_user].role do
      "users" ->
        conn
      "admin" ->
        conn
        |> send_resp(401, "You are not authorized to access this page.")
    end
  end
end
