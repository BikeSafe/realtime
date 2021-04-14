defmodule Realtime.Repo.Migrations.InterestPointTable do
  use Ecto.Migration

  alias Realtime.InterestPoints.InterestPoint

  def up do
    execute("CREATE EXTENSION IF NOT EXISTS postgis")

    create table(:interest_point) do
      add :event_type, :integer, null: false
    end

    execute("SELECT AddGeometryColumn('interest_point', 'location', 4326, 'POINT', 2)")
    execute("CREATE INDEX interest_point_location_index on interest_point USING gist (location)")

    flush()
  end

  def down do
    drop(table(:interest_point))
    execute("DROP EXTENSION IF EXISTS postgis")
  end
end
