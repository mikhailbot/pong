defmodule PongWeb.PageController do
  use PongWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
