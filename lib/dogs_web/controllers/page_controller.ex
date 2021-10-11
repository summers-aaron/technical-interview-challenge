defmodule DogsWeb.PageController do
  use DogsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
