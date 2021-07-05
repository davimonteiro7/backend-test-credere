defmodule SimuladorDeSonda.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SimuladorDeSondaWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SimuladorDeSonda.PubSub},
      # Start the Endpoint (http/https)
      SimuladorDeSondaWeb.Endpoint
      # Start a worker by calling: SimuladorDeSonda.Worker.start_link(arg)
      # {SimuladorDeSonda.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SimuladorDeSonda.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SimuladorDeSondaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
