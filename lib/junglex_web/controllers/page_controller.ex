defmodule JunglexWeb.PageController do
  use JunglexWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
