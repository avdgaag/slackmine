defmodule Slackmine.Redmine.Memory do
  @behaviour Slackmine.Redmine

  @moduledoc """
  Access the Redmine API using the credentials found in the application
  configuration to collect information about tickets.
  """

  def get_issue("4567") do
    response =
      %{
        "assigned_to" => %{
          "id" => 123,
          "name" => "John Cleese"
        },
        "author" => %{
          "id" => 456,
          "name" => "Graham Chapman"
        },
        "created_on" => "2016-04-08T08:49:42Z",
        "description" => "Stuff does not work!",
        "done_ratio" => 0,
        "fixed_version" => %{
          "id" => 1,
          "name" => "1.0"
        },
        "id" => 4567,
        "project" => %{
          "id" => 1,
          "name" => "New Site"
        },
        "start_date" => "2016-04-08",
        "status" => %{
          "id" => 1,
          "name" => "Doing"
        },
        "subject" => "Urgent bug",
        "tracker" => %{
          "id" => 2,
          "name" => "Feature"
        },
        "updated_on" => "2016-04-29T12:05:19Z"
      }
    {:ok, response, "http://example.com/issues/4567"}
  end

  def get_issue(_id) do
    {:error, "not found"}
  end
end
