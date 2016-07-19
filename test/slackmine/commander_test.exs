defmodule Slackmine.CommanderTest do
  use ExUnit.Case, async: true

  test "it can describe a single ticket" do
    assert Slackmine.Commander.run("show 4567") == %{text: "<http://example.com/issues/4567|4567>: Urgent bug (Doing)", response_type: "in_channel"}
  end

  test "it shows an error when the ticket could not be found" do
    assert Slackmine.Commander.run("show 1234") == %{text: "I can't find that ticket.", response_type: "ephemeral"}
  end

  test "it respond with an error for other commands" do
    assert Slackmine.Commander.run("do it") == %{response_type: "ephemeral", text: "Sorry, I don't know what you mean."}
  end
end
