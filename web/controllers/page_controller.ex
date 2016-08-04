defmodule Eskwela.PageController do
  use Eskwela.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
