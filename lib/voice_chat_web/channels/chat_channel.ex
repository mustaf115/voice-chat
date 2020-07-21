defmodule VoiceChatWeb.ChatChannel do
  use Phoenix.Channel
  alias VoiceChatWeb.Messages

  def join("chat:lobby", _msg, socket) do
    {:ok, %{msgs: Messages.get_msgs}, socket}
  end

  def join("chat:" <> _id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    messages = Messages.in_msg(body, socket.assigns.user_email)
    broadcast! socket, "new_msg", %{body: messages}
    {:noreply, socket}
  end
end
