defmodule Pong.MailerTest do
  @moduledoc """
  """

  use ExUnit.Case
  use Bamboo.Test
  use Pong.DataCase

  alias Pong.{Mailer, Monitors}

  @valid_attrs %{ip_address: "8.8.8.8", name: "some name"}

  def host_fixture(attrs \\ %{}) do
    {:ok, host} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Monitors.create_host()

    host
  end

  test "down notice is sent" do
    host = host_fixture()
    email = Mailer.send_down_notice(host)

    assert email.html_body =~ "#{host.name} is down"
  end

  test "up notice is sent" do
    host = host_fixture()
    email = Mailer.send_up_notice(host)

    assert email.html_body =~ "#{host.name} is back up"
  end
end
