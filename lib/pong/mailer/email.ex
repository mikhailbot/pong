defmodule Pong.Mailer.Email do
  @moduledoc """
  Email templates and composer
  """
  import Bamboo.Email

  use Bamboo.Phoenix, view: PongWeb.EmailView

  def generate_down_notice(host) do
    base_email
    |> subject("#{host.name} is down!")
    |> assign(:host, host)
    |> render(:host_down)
  end

  def generate_up_notice(host) do
    base_email
    |> subject("#{host.name} is back up!")
    |> assign(:host, host)
    |> render(:host_up)
  end

  defp base_email do
    new_email
    |> to("foo@emample.com")
    |> from("Ping Monitor <pong@monitor.pri>")
    |> put_html_layout({PongWeb.LayoutView, "email.html"})
  end
end
