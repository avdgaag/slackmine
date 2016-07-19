defmodule Slackmine.Redmine do
  @callback get_issue(binary) :: %{binary => binary}
end
