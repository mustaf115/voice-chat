defmodule VoiceChat.Repo do
  use Ecto.Repo,
    otp_app: :voice_chat,
    adapter: Ecto.Adapters.Postgres
end
