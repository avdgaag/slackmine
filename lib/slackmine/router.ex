defmodule Slackmine.Router do
  use Plug.Router
  @token Application.get_env(:slackmine, :slack_token)

  @moduledoc """
  The web endpoints that we expose to the world. This includes a basic homepage
  and the endpoint exposed to Slack to accept incoming requests.
  """

  plug Plug.Parsers, parsers: [:urlencoded, :multipart]
  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/" do
   send_resp(conn, 200, "Hello, world!")
  end

  post "/command" do
    if conn.params["token"] == @token do
      Slackmine.Worker.respond(
        conn.params["response_url"],
        conn.params["text"]
      )
      send_resp(conn, 200, "Give me a second...")
    else
      send_resp(conn, 401, "Unauthorized")
    end
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
