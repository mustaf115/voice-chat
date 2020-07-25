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
        |> put_session(:username, user.username)
        |> configure_session(renew: true)
        |> redirect(to: "/chat")
      {:error, _} ->
        conn
        |> put_flash(:error, "Incorrect credentials")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def delete(conn, _) do
    conn
    |> clear_session()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
