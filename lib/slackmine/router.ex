defmodule Slackmine.Router do
  use Plug.Router

  plug Plug.Parsers, parsers: [:urlencoded]
  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Hello, world!")
  end

  post "/command" do
    send_resp(conn, 200, Slackmine.Commander.run(conn.params["text"]))
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
