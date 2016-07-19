defmodule Slackmine.Commander do
  require Logger
  @redmine_client Application.get_env(:slackmine, :redmine_client)

  @moduledoc """
  This module is responsible for interpreting incoming commands and building a
  response. This will trigger communication with Redmine to gather relevant
  information.
  """

  def run("show " <> id) do
    case @redmine_client.get_issue(id) do
      {:ok, issue, url} ->
        public_response("<#{url}|#{id}>: #{issue["subject"]} (#{issue["status"]["name"]})", issue["description"])
      {_, msg} ->
        Logger.error "Error looking up " <> id <> ": " <> msg
        private_response("I can't find that ticket.")
    end
  end

  def run("help") do
    private_response("Try `show 1234`")
  end

  def run(_cmd) do
    private_response("Sorry, I don't know what you mean.")
  end

  defp public_response(text) do
    Map.merge(private_response(text), %{response_type: "in_channel"})
  end

  defp public_response(text, attachment) do
    Map.merge(public_response(text), %{attachments: [%{text: attachment}]})
  end

  defp private_response(text) do
    %{text: text, response_type: "ephemeral"}
  end
end
