defmodule ApiWeb.EventControllerTest do
  use ApiWeb.ConnCase

  alias Api.Calendar
  alias Api.Calendar.Event

  def fixture(:event, from, to) do
    {:ok, start_time} = NaiveDateTime.from_iso8601(from)
    {:ok, end_time} = NaiveDateTime.from_iso8601(to)

    {:ok, event} = Db.DataCase.fixture(:event, %{
      start_time: start_time,
      end_time: end_time,
      rrule: RruleChecker.rrule(%{from: start_time, until: end_time, freq: :daily})
    })

    event
  end

  setup %{conn: conn} do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Db.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Db.Repo, {:shared, self()})

    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all events", %{conn: conn} do
      event = fixture(:event, "2016-12-01 00:00:00", "2016-12-06 00:00:00")

      conn = get conn, event_path(conn, :index), from: "2016-12-05 00:00:00", to: "2016-12-12 00:00:00"

      assert json_response(conn, 200)["data"] == [
        %{"id" => event.id, "title" => "title", "start_time" => "2016-12-05T00:00:00", "end_time" => "2016-12-05T01:00:00"},
        %{"id" => event.id, "title" => "title", "start_time" => "2016-12-06T00:00:00", "end_time" => "2016-12-06T01:00:00"}
      ]
    end
  end

  defp create_event(_) do
    event = fixture(:event)
    {:ok, event: event}
  end
end
