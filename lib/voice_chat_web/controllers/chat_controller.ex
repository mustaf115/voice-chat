defmodule VoiceChatWeb.ChatController do
  use VoiceChatWeb, :controller

  def index(conn, _params) do
    conn
    |> render(:index)
  end
end
