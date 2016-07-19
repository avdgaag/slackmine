defmodule Slackmine.CommanderTest do
  use ExUnit.Case, async: true

  test "it can describe a single ticket" do
    assert Slackmine.Commander.run("show 4567") == "4567: Urgent bug (Doing)"
  end

  test "it shows an error when the ticket could not be found" do
    assert Slackmine.Commander.run("show 1234") == "I can't find that ticket."
  end

  test "it respond with an error for other commands" do
    assert Slackmine.Commander.run("do it") == "Sorry, I don't know what you mean."
  end
end
