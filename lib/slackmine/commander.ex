defmodule Slackmine.Commander do
  require Logger
  @redmine_client Application.get_env(:slackmine, :redmine_client)

  def run("show " <> id) do
    case @redmine_client.get_issue(id) do
      {:ok, issue, url} ->
        public_response("#{id}: #{issue["subject"]} (#{issue["status"]["name"]}, #{url})")
      {_, msg} ->
        Logger.error "Error looking up " <> id <> ": " <> msg
        private_response("I can't find that ticket.")
    end
  end

  def run(_cmd) do
    private_response("Sorry, I don't know what you mean.")
  end

  defp public_response(text) do
    %{text: text, response_type: "in_channel"}
  end

  defp private_response(text) do
    %{text: text, response_type: "ephemeral"}
  end
end
