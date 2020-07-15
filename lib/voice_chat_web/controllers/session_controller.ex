defmodule VoiceChatWeb.SessionController do
  use VoiceChatWeb, :controller

  alias VoiceChat.Accounts

  def new(conn, _) do
    render(conn, :new)
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Accounts.login(email, password) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> redirect(to: "/chat")
      {:error, :unauthorized} ->
        conn
        |> put_flash(:error, "Incorrect credentials")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end
end
