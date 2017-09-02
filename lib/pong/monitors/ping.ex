defmodule Pong.Monitors.Ping do
  @moduledoc """
  Module to ping IP addresses
  https://github.com/seven1m/30-days-of-elixir/blob/master/09-ping.exs
  """

  def ping_args(ip) do
    ["-c", "1", "-t", "5", ip]
  end

  def check_host(ip_address) do
    # This is a Ruby-ish way of dealing with failure...
    # Discover the "Elixir way"
    try do
      # return code should be handled somehow with pattern matching
      {cmd_output, _} = System.cmd("ping", ping_args(ip_address))

      alive? = not Regex.match?(~r/100(\.0)?% packet loss/, cmd_output)

      latency =
        case Regex.run(~r/(?<=time=)(.*)(?=\.)/, cmd_output) do
          [_ | timeout] -> String.to_integer(Enum.fetch!(timeout, 0))
          _ -> 0
        end

      {:ok, {ip_address, :os.system_time(:seconds), latency}}
    rescue
      e -> {:error, e}
    end
  end
end
