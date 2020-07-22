defmodule VoiceChat.Repo.Migrations.ExtendUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      remove :name
      add :email, :string
      add :username, :string
    end
  end
end
