defmodule Slackmine.SlackTest do
  use ExUnit.Case, async: true

  test "builds a private response for a text" do
    assert Slackmine.Slack.private_response("hello") == %{text: "hello", response_type: "ephemeral"}
  end

  test "builds a public response for a text" do
    assert Slackmine.Slack.public_response("hello") == %{text: "hello", response_type: "in_channel"}
  end

  test "builds a public response with a text attachment" do
    assert Slackmine.Slack.public_response("hello", "attachment") == %{text: "hello", response_type: "in_channel", attachments: [%{text: "attachment"}]}
  end
end
