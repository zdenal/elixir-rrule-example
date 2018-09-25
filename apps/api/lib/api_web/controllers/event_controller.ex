defmodule ApiWeb.EventController do
  use ApiWeb, :controller

  alias Api.Calendar
  alias Api.Calendar.Event

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    #events = Calendar.list_events()
    events = []
    render(conn, "index.json", events: events)
  end

  #def show(conn, %{"id" => id}) do
    #event = Calendar.get_event!(id)
    #render(conn, "show.json", event: event)
  #end
end
