defmodule Api.Calendar do
  @moduledoc """
  The Calendar context.
  """

  def events_between(from, to) do
    events = Db.events_between(from, to)

    events
    |> Enum.map(&({&1.id, &1.rrule}))
    |> RruleChecker.filter(from, to)
    |> Enum.map(&generate_occurences(&1, events))
    |> List.flatten()
  end

  defp generate_occurences({id, dates}, events) do
    event = Enum.find(events, &(&1.id == id))

    dates
    |> Enum.map(&generate_occurence(&1, event))
  end

  defp generate_occurence(date, event) do
    %{id: event.id, start_time: date, end_time: NaiveDateTime.add(date, event.duration), title: event.title}
  end
end
