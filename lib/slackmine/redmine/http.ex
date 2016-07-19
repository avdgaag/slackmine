defmodule Slackmine.Redmine.HTTP do
  @behaviour Slackmine.Redmine

  @redmine_domain Application.get_env(:slackmine, :redmine_domain)
  @redmine_api_key Application.get_env(:slackmine, :redmine_api_key)

  @moduledoc """
  Access the Redmine API using the credentials found in the application
  configuration to collect information about tickets.
  """

  @doc "Fetch a JSON-encoded issue from Redmine and return its details"
  def get_issue(issue_id) do
    url = build_url("/issues/#{issue_id}.json")
    case get_response(url) do
      %HTTPotion.Response{body: body, status_code: 200} ->
        %{"issue" => issue} = Poison.decode!(body)
        {:ok, issue, String.replace_suffix(url, ".json", "")}
      _ ->
        {:error, "Not Found"}
    end
  end

  defp get_response(url) do
    HTTPotion.get(
      url,
      headers: ["X-Redmine-Api-Key": @redmine_api_key],
      timout: 2_500
    )
  end

  defp build_url(path) do
    "#{@redmine_domain}#{path}"
  end
end
