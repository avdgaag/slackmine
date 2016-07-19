use Mix.Config
config :slackmine,
  slack_token: System.get_env("SLACK_TOKEN"),
  redmine_domain: System.get_env("REDMINE_DOMAIN"),
  redmine_api_key: System.get_env("REDMINE_API_KEY")
