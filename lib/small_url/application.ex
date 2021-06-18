defmodule SmallUrl.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      SmallUrl.Repo,
      # Start the Telemetry supervisor
      SmallUrlWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SmallUrl.PubSub},
      # Start the Endpoint (http/https)
      SmallUrlWeb.Endpoint
      # Start a worker by calling: SmallUrl.Worker.start_link(arg)
      # {SmallUrl.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SmallUrl.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SmallUrlWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
