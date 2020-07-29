defmodule VoiceChatWeb.ChatChannel do
  use Phoenix.Channel
  alias VoiceChatWeb.Presence
  alias VoiceChatWeb.Messages

  def join("chat:lobby", _msg, socket) do
    send(self(), :after_join)
    {:ok, %{msgs: Messages.get_msgs}, socket}
  end

  def join("chat:private", _params, _socket) do
    {:ok, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    messages = Messages.in_msg(body, socket.assigns.username)
    broadcast! socket, "new_msg", %{body: messages}
    {:noreply, socket}
  end

  def handle_out("new_msg", msg, socket) do
    unless socket.assigns.user_id == msg.user_id do
      push(socket, "new_msg", msg)
    end
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
