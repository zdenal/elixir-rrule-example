defmodule ApiWeb.EventView do
  use ApiWeb, :view
  alias ApiWeb.EventView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{
      id: event.id,
      title: event.title,
      start_time: event.start_time,
      end_time: event.end_time
    }
  end
end
