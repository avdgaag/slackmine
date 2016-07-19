defmodule Slackmine.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts Slackmine.Router.init([])

  test "returns a greeting for the root URL" do
    conn = conn(:get, "/")
    conn = Slackmine.Router.call(conn, @opts)
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "Hello, world!"
  end

  test "responds to commands posted to /command with valid token" do
    conn = conn(:post, "/command", token: "foobar")
    conn = Slackmine.Router.call(conn, @opts)
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "Sorry, I don't know what you mean."
  end

  test "responds with error when posting commands with invalid token" do
    conn = conn(:post, "/command", token: "invalid")
    conn = Slackmine.Router.call(conn, @opts)
    assert conn.state == :sent
    assert conn.status == 401
    assert conn.resp_body == "Unauthorized"
  end

  test "renders 404 when there is no handler" do
    conn = conn(:get, "/favicon.ico")
    conn = Slackmine.Router.call(conn, @opts)
    assert conn.state == :sent
    assert conn.status == 404
    assert conn.resp_body == "Not Found"
  end
end
