defmodule Slackmine.Router do
  use Plug.Router

  @token Application.get_env(:slackmine, :slack_token)

  plug Plug.Parsers, parsers: [:urlencoded, :multipart]
  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Hello, world!")
  end

  post "/command" do
    if conn.params["token"] == @token do
      body = Slackmine.Commander.run(conn.params["text"])
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Poison.encode!(body))
    else
      send_resp(conn, 401, "Unauthorized")
    end
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
