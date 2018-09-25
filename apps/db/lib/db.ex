defmodule Db do
  @moduledoc """
  Documentation for Db.
  """

  alias Db.{Event, Repo}
  alias Db.Queries.EventsBetween

  def create_event(attrs) do
    %Event{}
    |> Event.create_changeset(attrs)
    |> Repo.insert()
  end

  def events_between(from, to) do
    EventsBetween.new(from, to)
    |> Repo.all
  end
end
