defmodule TestResuelve.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TestResuelveWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TestResuelve.PubSub},
      # Start the Endpoint (http/https)
      TestResuelveWeb.Endpoint
      # Start a worker by calling: TestResuelve.Worker.start_link(arg)
      # {TestResuelve.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TestResuelve.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    TestResuelveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
