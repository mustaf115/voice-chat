defmodule VoiceChatWeb.UserController do
  use VoiceChatWeb, :controller
  alias VoiceChat.Accounts

  def new(conn, _params) do
    render conn, :new
  end

  def create(conn, params) do
    case Accounts.create_user(params) do
      {:ok, user} ->
        conn
        |> assign(:user, user)
        |> redirect(to: "chat")
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Invalid input")
        |> render(:new, changeset: changeset)
    end
  end

  def delete(conn, %{id: id}) do

  end
end
