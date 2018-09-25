defmodule Api.CalendarTest do
  #use ExUnit.Case
  use Db.DataCase

  alias Api.Calendar

  describe "events_between" do
    test "return correctly event's occurences" do
      start_time = ~N[2016-12-01 00:00:00]
      end_time = ~N[2016-12-06 00:00:00]

      {:ok, event} = Db.DataCase.fixture(:event, %{
        start_time: start_time,
        end_time: end_time,
        rrule: RruleChecker.rrule(%{from: start_time, until: end_time, freq: :daily})
      })

      assert [
        %{id: event.id, title: "title", start_time: ~N[2016-12-05 00:00:00], end_time: ~N[2016-12-05 01:00:00]},
        %{id: event.id, title: "title", start_time: ~N[2016-12-06 00:00:00], end_time: ~N[2016-12-06 01:00:00]}
      ] == Calendar.events_between(~N[2016-12-05 00:00:00], ~N[2016-12-12 00:00:00])
    end
  end
end
