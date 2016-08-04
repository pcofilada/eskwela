defmodule Eskwela.LevelControllerTest do
  use Eskwela.ConnCase

  alias Eskwela.Level
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, level_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing levels"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, level_path(conn, :new)
    assert html_response(conn, 200) =~ "New level"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, level_path(conn, :create), level: @valid_attrs
    assert redirected_to(conn) == level_path(conn, :index)
    assert Repo.get_by(Level, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, level_path(conn, :create), level: @invalid_attrs
    assert html_response(conn, 200) =~ "New level"
  end

  test "shows chosen resource", %{conn: conn} do
    level = Repo.insert! %Level{}
    conn = get conn, level_path(conn, :show, level)
    assert html_response(conn, 200) =~ "Show level"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, level_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    level = Repo.insert! %Level{}
    conn = get conn, level_path(conn, :edit, level)
    assert html_response(conn, 200) =~ "Edit level"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    level = Repo.insert! %Level{}
    conn = put conn, level_path(conn, :update, level), level: @valid_attrs
    assert redirected_to(conn) == level_path(conn, :show, level)
    assert Repo.get_by(Level, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    level = Repo.insert! %Level{}
    conn = put conn, level_path(conn, :update, level), level: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit level"
  end

  test "deletes chosen resource", %{conn: conn} do
    level = Repo.insert! %Level{}
    conn = delete conn, level_path(conn, :delete, level)
    assert redirected_to(conn) == level_path(conn, :index)
    refute Repo.get(Level, level.id)
  end
end
