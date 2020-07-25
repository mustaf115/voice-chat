defmodule VoiceChatWeb.ChatChannel do
  use Phoenix.Channel
  alias VoiceChatWeb.Presence
  alias VoiceChatWeb.Messages

  def join("chat:lobby", _msg, socket) do
    send(self(), :after_join)
    {:ok, %{msgs: Messages.get_msgs}, socket}
  end

  def join("chat:" <> _id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    messages = Messages.in_msg(body, socket.assigns.username)
    broadcast! socket, "new_msg", %{body: messages}
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    {:ok, _} = Presence.track(socket, socket.assigns.username, %{
      online_at: inspect(System.system_time(:second))
      })

    push(socket, "presence_state", Presence.list(socket))
    {:noreply, socket}
  end
end
