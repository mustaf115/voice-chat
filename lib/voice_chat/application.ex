defmodule VoiceChat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      VoiceChat.Repo,
      # Start the Telemetry supervisor
      VoiceChatWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: VoiceChat.PubSub},
      # Start the Endpoint (http/https)
      VoiceChatWeb.Endpoint,
      # Start a worker by calling: VoiceChat.Worker.start_link(arg)
      # {VoiceChat.Worker, arg}
      {VoiceChatWeb.Messages, :queue.new}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VoiceChat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    VoiceChatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
