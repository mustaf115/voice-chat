defmodule VoiceChatWeb.ChatController do
  use VoiceChatWeb, :controller

  def index(conn, _params) do
    # IO.inspect(conn, label: "AAAAAAAAA")
    conn
    |> assign(:user_email, get_session(conn, :user_email))
    |> render(:index)
  end
end
