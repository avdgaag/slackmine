defmodule Slackmine.Commander do
  require Logger
  @redmine_client Application.get_env(:slackmine, :redmine_client)

  def run("show " <> id) do
    case @redmine_client.get_issue(id) do
      {:ok, issue} ->
        to_string(issue["id"]) <> ": " <> issue["subject"] <> " (" <> issue["status"]["name"] <> ")"
      {_, msg} ->
        Logger.error "Error looking up " <> id <> ": " <> msg
        "I can't find that ticket."
    end
  end

  def run(_cmd) do
    "Sorry, I don't know what you mean."
  end
end
