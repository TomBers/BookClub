defmodule Bkclb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Bkclb.Repo,
      # Start the Telemetry supervisor
      BkclbWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Bkclb.PubSub},
      # Start the Endpoint (http/https)
      BkclbWeb.Endpoint
      # Start a worker by calling: Bkclb.Worker.start_link(arg)
      # {Bkclb.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bkclb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BkclbWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
