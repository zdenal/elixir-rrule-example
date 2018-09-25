defmodule Db.Event do
  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  schema "events" do
    field :title, :string
    field :start_time, :naive_datetime
    field :end_time, :naive_datetime
    field :rrule, :string
    field :duration, :integer
  end


  def create_changeset(%Event{} = event, attrs) do
    event
    |> cast(attrs, create_cast_attrs())
    |> validate_required(required_attrs())
  end

  defp create_cast_attrs,
    do: [:title, :start_time, :end_time, :rrule, :duration]

  defp required_attrs,
    do: [:title, :start_time, :end_time, :duration]
end

