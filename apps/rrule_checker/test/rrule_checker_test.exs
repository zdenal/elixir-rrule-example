defmodule RruleCheckerTest do
  use ExUnit.Case

  alias Cocktail.Schedule
  alias Cocktail.Builder.ICalendar

  # TODO: test case where until < to
  describe "#filter" do
    setup do
      e_daily = {1, fixture(:icalendar, Schedule.new(~N[2016-12-14 00:00:00]) |> Schedule.add_recurrence_rule(:daily, until: ~N[2016-12-31 00:00:00]))}
      e_weekly = {2, fixture(:icalendar, Schedule.new(~N[2016-12-13 00:00:00]) |> Schedule.add_recurrence_rule(:weekly, until: ~N[2016-12-31 00:00:00]))}

      {:ok, e_weekly: e_weekly, e_daily: e_daily}
    end

    test "filter and generate only for e_daily", %{e_weekly: e_weekly, e_daily: e_daily} do
      assert RruleChecker.filter([e_weekly, e_daily], ~N[2016-12-14 00:00:00], ~N[2016-12-15 00:00:00]) == [
        {1, [~N[2016-12-14 00:00:00], ~N[2016-12-15 00:00:00]]}
      ]
    end

    test "return nothing", %{e_weekly: e_weekly, e_daily: e_daily} do
      assert RruleChecker.filter([e_weekly, e_daily], ~N[2016-12-02 00:00:00], ~N[2016-12-04 00:00:00]) == []
    end

    defp fixture(:icalendar, schedule) do
      ICalendar.build(schedule)
    end
  end
end
