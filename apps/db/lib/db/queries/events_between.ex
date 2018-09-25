defmodule Db.Queries.EventsBetween do
  import Ecto.Query

  alias Db.Event

  def new(from, to) do
    from e in Event,
      where: e.start_time <= ^to and e.end_time >= ^from
  end
end
