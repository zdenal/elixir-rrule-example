defmodule RruleChecker do
  @moduledoc """
  Documentation for RruleChecker.
  """

  alias Cocktail.Parser
  alias Cocktail.Schedule

  @type event :: {non_neg_integer(), map()}

  @spec filter([event], Date.t(), Date.t()) :: [{non_neg_integer(), list()}]
  def filter(events, from, to) do
    events
    |> Enum.map(&parse/1)
    |> Enum.map(&change_until(&1, to))
    |> Enum.map(&get_occurrences(&1, from))
    |> Enum.map(&to_list/1)
    |> Enum.filter(&not_empty?/1)
  end

  defp parse({id, rrule}) do
    case Parser.ICalendar.parse(rrule) do
      {:ok, schedule} -> {id, schedule}
      _ -> raise ArgumentError
    end
  end

  defp change_until({id, schedule}, to) do
    {id, schedule |> Schedule.end_all_recurrence_rules(to)}
  end

  defp get_occurrences({id, schedule}, from) do
    {id, schedule |> Schedule.occurrences(from)}
  end

  defp to_list({id, stream}) do
    {id, stream |> Enum.to_list}
  end

  defp not_empty?({_id, []}), do: false
  defp not_empty?({_id, _list}), do: true
end
