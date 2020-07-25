defmodule VoiceChatWeb.ChatController do
  use VoiceChatWeb, :controller

  def index(conn, _params) do
    # IO.inspect(conn, label: "AAAAAAAAA")
    conn
    |> assign(:user, VoiceChat.Accounts.get_user!(get_session(conn, :user_id)))
    |> render(:index)
  end
end
