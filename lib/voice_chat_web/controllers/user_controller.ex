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
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Invalid input")
        |> render(:new, changeset: changeset)
    end
  end

  def delete(conn, %{id: id}) do
    case Accounts.get_user!(id) do
      {:ok, user} ->
        Accounts.delete_user(user)
      {:error, _} ->
        conn
        |> put_flash(:error, "something went wrong")
        |> redirect("/")
    end
  end
end
