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

  def public_response(text) do
    Map.merge(private_response(text), %{response_type: "in_channel"})
  end

  def public_response(text, attachment) do
    Map.merge(public_response(text), %{attachments: [%{text: attachment}]})
  end

  def private_response(text) do
    %{text: text, response_type: "ephemeral"}
  end
end
