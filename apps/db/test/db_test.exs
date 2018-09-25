defmodule DbTest do
  use Db.DataCase

  alias Db.Event

  describe "#create_event" do
    test "when event is invalid" do
      assert {:error, changeset} = fixture(:event, %{title: nil, duration: nil})

      assert %{title: ["can't be blank"]} = errors_on(changeset)
      assert %{duration: ["can't be blank"]} = errors_on(changeset)
      assert %{start_time: ["can't be blank"]} = errors_on(changeset)
      assert %{end_time: ["can't be blank"]} = errors_on(changeset)
      assert nil == errors_on(changeset)[:rrule]
    end

    test "when event is valid" do
      attrs = %{
        start_time: ~N[2017-01-01 00:00:00],
        end_time: ~N[2017-01-31 00:00:00],
      }

      assert {:ok, %Event{title: "title"}} = fixture(:event, attrs)
    end
  end

  describe "#events_between" do
    test "should return correct events" do
      {:ok, from_past} = fixture(:event, %{
        start_time: ~N[2016-12-01 00:00:00],
        end_time: ~N[2017-01-02 00:00:00]
      })
      {:ok, to_future} = fixture(:event, %{
        start_time: ~N[2017-01-02 00:00:00],
        end_time: ~N[2017-04-02 00:00:00]
      })
      {:ok, inside} = fixture(:event, %{
        start_time: ~N[2017-01-01 00:00:00],
        end_time: ~N[2017-01-02 00:00:00]
      })
      {:ok, from_past_to_future} = fixture(:event, %{
        start_time: ~N[2016-12-01 00:00:00],
        end_time: ~N[2017-04-02 00:00:00]
      })

      {:ok, past} = fixture(:event, %{
        start_time: ~N[2016-12-01 00:00:00],
        end_time: ~N[2016-12-21 00:00:00],
      })
      {:ok, future} = fixture(:event, %{
        start_time: ~N[2018-12-01 00:00:00],
        end_time: ~N[2018-12-21 00:00:00],
      })

      res_ids = Db.events_between(~N[2017-01-01 00:00:00], ~N[2017-01-03 00:01:00])
            |> Enum.map(&(&1.id))

      [from_past, to_future, inside, from_past_to_future]
      |> Enum.map(&(&1.id))
      |> Enum.each(fn e -> assert Enum.member?(res_ids, e) end)

      [past, future]
      |> Enum.map(&(&1.id))
      |> Enum.each(fn e -> refute Enum.member?(res_ids, e) end)
    end
  end
end
