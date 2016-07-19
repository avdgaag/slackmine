defmodule Slackmine.Responder do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def notify(callback_url, cmd) do
    GenServer.cast(__MODULE__, {:notify, callback_url, cmd})
  end

  def handle_cast({:notify, callback_url, cmd}, state) do
    cmd
    |> Slackmine.Commander.run
    |> Poison.encode!
    |> Slackmine.Slack.notify(callback_url, cmd)
    {:noreply, state}
  end
end
