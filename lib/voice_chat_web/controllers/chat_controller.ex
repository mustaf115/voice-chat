defmodule VoiceChatWeb.ChatController do
  use VoiceChatWeb, :controller

  def index(conn, _params) do
    conn
    |> put_layout(false)
    |> render(:index)
  end
end
