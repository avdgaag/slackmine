# Slackmine

Elixir application for querying a Redmine application using Slack slash commands. For example, using `/redmine show 1234` will show information about a Redmine ticket with ID 1234.

## Installation

Make sure you have Elixir 1.3 installed, and you have cloned this repository. Fetch and compile the dependencies:

```
% mix do deps.get, deps.compile
```

For development and testing mode, make sure you have a `config/secrets.exs` file with required configuration details. It should look like this:

```elixir
use Mix.Config
config :slackmine,
  redmine_domain: "http://url/to/redmine",
  redmine_api_key: "your_api_key"
```

That's it!

## Running the application

Run the server:

```
% mix run --no-halt
```

Now you can see the application at http://localhost:4000 -- but there's not much to see there. The interesting bit happens when you POST something to `/command`:

```
% curl --request POST \
--data "token=foobar" \
--data "text=show 1234" \
http://localhost:4000/command
```

This should give you a Slack-formatted JSON response.

## Deployment

Deploying this code to Heroku is easy thanks to the `app.json` included in this repo:

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

When you do deploy, do make sure you set the environment variables `REDMINE_DOMAIN`, `REDMINE_API_KEY` and `SLACK_TOKEN` (that last one is used for authentication).

## Configuration in Slack

Please refer to the Slack documentation on how to set up slash commands.
