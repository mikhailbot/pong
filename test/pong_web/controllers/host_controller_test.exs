defmodule PongWeb.HostControllerTest do
  use PongWeb.ConnCase

  alias Pong.Monitors

  @create_attrs %{check_frequency: 42, ip_address: "8.8.8.8", latency: 42, name: "some name", status: "some status"}
  @update_attrs %{check_frequency: 43, ip_address: "8.8.4.4", latency: 43, name: "some updated name", status: "some updated status"}
  @invalid_attrs %{check_frequency: nil, ip_address: nil, latency: nil, name: nil, status: nil}

  def fixture(:host) do
    {:ok, host} = Monitors.create_host(@create_attrs)
    host
  end

  describe "index" do
    test "lists all hosts", %{conn: conn} do
      conn = get conn, host_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Hosts"
    end
  end

  describe "new host" do
    test "renders form", %{conn: conn} do
      conn = get conn, host_path(conn, :new)
      assert html_response(conn, 200) =~ "New Host"
    end
  end

  describe "create host" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, host_path(conn, :create), host: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == host_path(conn, :show, id)

      conn = get conn, host_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Host"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, host_path(conn, :create), host: @invalid_attrs
      assert html_response(conn, 200) =~ "New Host"
    end
  end

  describe "edit host" do
    setup [:create_host]

    test "renders form for editing chosen host", %{conn: conn, host: host} do
      conn = get conn, host_path(conn, :edit, host)
      assert html_response(conn, 200) =~ "Edit Host"
    end
  end

  describe "update host" do
    setup [:create_host]

    test "redirects when data is valid", %{conn: conn, host: host} do
      conn = put conn, host_path(conn, :update, host), host: @update_attrs
      assert redirected_to(conn) == host_path(conn, :show, host)

      conn = get conn, host_path(conn, :show, host)
      assert html_response(conn, 200) =~ "8.8.4.4"
    end

    test "renders errors when data is invalid", %{conn: conn, host: host} do
      conn = put conn, host_path(conn, :update, host), host: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Host"
    end
  end

  describe "delete host" do
    setup [:create_host]

    test "deletes chosen host", %{conn: conn, host: host} do
      conn = delete conn, host_path(conn, :delete, host)
      assert redirected_to(conn) == host_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, host_path(conn, :show, host)
      end
    end
  end

  defp create_host(_) do
    host = fixture(:host)
    {:ok, host: host}
  end
end
