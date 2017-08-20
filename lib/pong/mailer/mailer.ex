defmodule Pong.Mailer do
  @moduledoc """
  Bamboo Mailer
  """
  use Bamboo.Mailer, otp_app: :pong

  alias Pong.Mailer
  alias Pong.Mailer.Email

  def send_down_notice(host) do
    host
    |> Email.generate_down_notice
    |> Mailer.deliver_now
  end

  def send_up_notice(host) do
    host
    |> Email.generate_up_notice
    |> Mailer.deliver_now
  end
end
