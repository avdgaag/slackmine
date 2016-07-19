defmodule Slackmine do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    port = Application.get_env(:slackmine, :port) || String.to_integer(System.get_env("PORT"))

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: Slackmine.Worker.start_link(arg1, arg2, arg3)
      # worker(Slackmine.Worker, [arg1, arg2, arg3]),

      Plug.Adapters.Cowboy.child_spec(:http, Slackmine.Router, [], [port: port]),
      worker(Slackmine.Responder, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Slackmine.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
