defmodule Db.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime
      add :rrule, :text
      add :duration, :integer
    end
  end
end
