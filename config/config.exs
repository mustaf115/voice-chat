# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :voice_chat,
  ecto_repos: [VoiceChat.Repo]

# Configures the endpoint
config :voice_chat, VoiceChatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "lYRhBnUyM7cTTVZfBIU0Xt4dNKsupbHgXDy8B3Qc17NGNM+v4GUIvrc9Oba5Uphd",
  render_errors: [view: VoiceChatWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: VoiceChat.PubSub,
  live_view: [signing_salt: "zXBwRsPw"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
