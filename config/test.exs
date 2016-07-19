use Mix.Config
config :logger, level: :error
config :slackmine,
  redmine_client: Slackmine.Redmine.Memory,
  port: 4000
