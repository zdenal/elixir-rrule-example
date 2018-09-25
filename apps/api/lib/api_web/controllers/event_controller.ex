defmodule ApiWeb.EventController do
  use ApiWeb, :controller

  alias Api.Calendar
  alias Api.Calendar.Event

  action_fallback ApiWeb.FallbackController

  def index(conn, %{"from" => from, "to" => to}) do
    {:ok, from} = NaiveDateTime.from_iso8601(from)
    {:ok, to} = NaiveDateTime.from_iso8601(to)

    events = Calendar.events_between(from, to)
    render(conn, "index.json", events: events)
  end

  #def show(conn, %{"id" => id}) do
    #event = Calendar.get_event!(id)
    #render(conn, "show.json", event: event)
  #end
end
