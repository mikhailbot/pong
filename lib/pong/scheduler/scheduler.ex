defmodule Pong.Scheduler do
  @moduledoc """
  The Quantum scheduler context
  """

  use Quantum.Scheduler,
  otp_app: :pong
end
