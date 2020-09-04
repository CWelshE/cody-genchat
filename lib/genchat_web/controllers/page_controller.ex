defmodule GenchatWeb.PageController do
  use GenchatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
