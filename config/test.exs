use Mix.Config
config :ex_unit, capture_log: true
config :slackmine,
  redmine_client: Slackmine.Redmine.Memory,
  port: 4000
