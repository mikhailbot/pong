defmodule Pong.MailerTest do
  @moduledoc """
  """

  use ExUnit.Case
  use Bamboo.Test

  alias Pong.Mailer

  test "down notice is sent" do
    email = Mailer.send_down_notice

    assert email.html_body =~ "Something went down"
  end

  test "up notice is sent" do
    email = Mailer.send_up_notice

    assert email.html_body =~ "Something came up"
  end
end
