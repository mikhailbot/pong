defmodule PongWeb.PageControllerTest do
  use PongWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Pong Monitor"
  end
end
