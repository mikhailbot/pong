defmodule Pong.Mailer do
  @moduledoc """
  Bamboo Mailer
  """
  use Bamboo.Mailer, otp_app: :pong

  alias Pong.Mailer
  alias Pong.Mailer.Email

  def send_down_notice do
    Email.down_notice
    |> Mailer.deliver_now
  end

  def send_up_notice do
    Email.up_notice
    |> Mailer.deliver_now
  end
end
