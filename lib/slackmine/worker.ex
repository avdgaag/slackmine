defmodule Slackmine.Worker do
  use GenServer

  @moduledoc """
  GenServer for asynchronously dealing with incoming commands and relaying the
  results back to Slack using its callback URL. We _could_ respond immediately,
  but Slack requires us to respond quickly. If the Redmine, which we will query,
  does not respond quickly, nor can we. Use this async pattern allows us to
  respond whenever Redmine responds.
  """

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc """
  Process `cmd` and use `callback_url` to notify Slack of the results.
  """
  def respond(callback_url, cmd) do
    GenServer.cast(__MODULE__, {:respond, callback_url, cmd})
  end

  def handle_cast({:respond, callback_url, cmd}, state) do
    cmd
    |> Slackmine.Commander.run
    |> Poison.encode!
    |> Slackmine.Slack.notify(callback_url, cmd)
    {:noreply, state}
  end
end
