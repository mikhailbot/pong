defmodule Pong.Mailer.Email do
  @moduledoc """
  Email templates and composer
  """
  import Bamboo.Email

  def down_notice do
    new_email()
    |> to("foo@example.com")
    |> from("me@example.com")
    |> subject("Down!!!")
    |> html_body("<strong>Something went down!</strong>")
    |> text_body("Something went down!")
  end

  def up_notice do
    new_email()
    |> to("foo@example.com")
    |> from("me@example.com")
    |> subject("Up!!!")
    |> html_body("<strong>Something came up!</strong>")
    |> text_body("Something came up!")
  end
end
