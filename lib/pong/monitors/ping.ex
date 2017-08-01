defmodule Pong.Monitors.Ping do
  @doc """
  Module to ping IP addresses
  https://github.com/seven1m/30-days-of-elixir/blob/master/09-ping.exs
  """

  def ping_args(ip) do
    wait_opt = if darwin?, do: '-W', else: '-w'
    ["-c", "1", wait_opt, "5", ip]
  end

  def darwin? do
    {output, 0} = System.cmd("uname", [])
    String.rstrip(output) == "Darwin"
  end

  def check_host(ip_address) do
    # This is a Ruby-ish way of dealing with failure...
    # TODO: Discover the "Elixir way"
    try do
      # return code should be handled somehow with pattern matching
      {cmd_output, _} = System.cmd("ping", ping_args(ip_address))

      alive? = not Regex.match?(~r/100(\.0)?% packet loss/, cmd_output)

      case Regex.run(~r/stddev = (.*?)\//, cmd_output) do
        [ _ | timeout ] -> latency = String.to_float(Enum.fetch!(timeout, 0))
        _ -> latency = 0
      end

      # IO.inspect latency

      {:ok, { alive?, latency }}
    rescue
      e -> {:error, e}
    end
  end
end
