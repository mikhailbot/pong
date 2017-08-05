defmodule Pong.MonitorsChecksTest do
  @moduledoc """
  """

  use Pong.DataCase

  alias Pong.Monitors

  describe "checks" do
    alias Pong.Monitors.Check

    @valid_attrs %{latency: 42}
    @valid_host_attrs %{ip_address: "8.8.8.8", name: "some name"}

    def host_fixture(attrs \\ %{}) do
      {:ok, host} =
        attrs
        |> Enum.into(@valid_host_attrs)
        |> Monitors.create_host()

      host
    end

    test "create_check/1 with valid data creates a check" do
      host = host_fixture()

      assert {:ok, %Check{} = check} = Monitors.create_check(host, @valid_attrs)
      assert check.latency == 42
    end
  end
end
