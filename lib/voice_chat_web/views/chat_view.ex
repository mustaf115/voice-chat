defmodule VoiceChatWeb.ChatView do
  use VoiceChatWeb, :view

  def render("scripts.html", assigns) do
    ~E[<script defer src="<%= Routes.static_path(@conn, "/js/chat.js") %>"></script>]
  end
end
