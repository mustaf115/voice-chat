defmodule VoiceChatWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "chat:*", VoiceChatWeb.ChatChannel

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  @impl true
  def connect(%{"token" => token}, socket, _conn) do
    case Phoenix.Token.verify(VoiceChatWeb.Endpoint, "user_email", token, max_age: 86400) do
      {:ok, user_email} ->
        IO.inspect(user_email, label: "okay")
        {:ok, assign(socket, :user_email, user_email)}
      {:error, err} ->
        IO.inspect(err, label: "not okay")
        :error
    end
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     VoiceChatWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  @impl true
  def id(socket), do: socket.assigns.user_email
end
