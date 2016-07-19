defmodule Slackmine.Slack do
  require Logger

  @moduledoc """
  Deal with communication with Slack.
  """

  @doc """
  Send a POST request to Slack using a given URL and post body. The response
  will only be logged.
  """
  def notify(body, url, cmd) do
    response = HTTPotion.post(
      url,
      body: body,
      headers: ["Content-Type": "application/json"]
    )

    case response do
      %HTTPotion.Response{status_code: 200} ->
        Logger.info "Notified Slack re: #{cmd}"
      %HTTPotion.Response{body: body, status_code: code} ->
        Logger.warn "Failed to notify Slack re: #{cmd} (#{code} #{body})"
      %HTTPotion.ErrorResponse{message: msg} ->
        Logger.warn "Failed to notify Slack re: #{cmd} (#{msg})"
      _ ->
        Logger.warn "An unknown error occured"
    end
  end
end
