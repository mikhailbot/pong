defmodule Pong.MonitorsTest do
  use Pong.DataCase

  alias Pong.Monitors

  describe "hosts" do
    alias Pong.Monitors.Host

    @valid_attrs %{check_frequency: 42, ip_address: "8.8.8.8", latency: 42, name: "some name", status: "some status"}
    @update_attrs %{check_frequency: 43, ip_address: "8.8.4.4", latency: 43, name: "some updated name", status: "some updated status"}
    @invalid_attrs %{check_frequency: nil, ip_address: nil, latency: nil, name: nil, status: nil}

    def host_fixture(attrs \\ %{}) do
      {:ok, host} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Monitors.create_host()

      host
    end

    test "list_hosts/0 returns all hosts" do
      host = host_fixture()
      assert Monitors.list_hosts() == [host]
    end

    test "get_host!/1 returns the host with given id" do
      host = host_fixture()
      assert Monitors.get_host!(host.id) == host
    end

    test "create_host/1 with valid data creates a host" do
      assert {:ok, %Host{} = host} = Monitors.create_host(@valid_attrs)
      assert host.check_frequency == 42
      assert host.ip_address == "8.8.8.8"
      assert host.name == "some name"
    end

    test "create_host/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Monitors.create_host(@invalid_attrs)
    end

    test "update_host/2 with valid data updates the host" do
      host = host_fixture()
      assert {:ok, host} = Monitors.update_host(host, @update_attrs)
      assert %Host{} = host
      assert host.check_frequency == 43
      assert host.ip_address == "8.8.4.4"
      assert host.name == "some updated name"
    end

    test "update_host/2 with invalid data returns error changeset" do
      host = host_fixture()
      assert {:error, %Ecto.Changeset{}} = Monitors.update_host(host, @invalid_attrs)
      assert host == Monitors.get_host!(host.id)
    end

    test "delete_host/1 deletes the host" do
      host = host_fixture()
      assert {:ok, %Host{}} = Monitors.delete_host(host)
      assert_raise Ecto.NoResultsError, fn -> Monitors.get_host!(host.id) end
    end

    test "change_host/1 returns a host changeset" do
      host = host_fixture()
      assert %Ecto.Changeset{} = Monitors.change_host(host)
    end
  end
end
