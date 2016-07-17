defmodule Issues.PageController do
  use Issues.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
