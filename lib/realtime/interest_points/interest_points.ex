defmodule Realtime.InterestPoints do
  alias Realtime.{Repo, InterestPoints.InterestPoint}
  import Ecto.Query
  import Geo.PostGIS

  def get_points_in_radius(coords, rad) do
    center = %Geo.Point{coordinates: coords, srid: 4326}

    query =
      from point in "interest_point",
        where: st_dwithin(^center, point.location, ^rad),
        select: %{id: point.id, event_type: point.event_type, location: point.location}

    Repo.all(query)
  end

  def create_point(coords, type) do
    location = %Geo.Point{coordinates: coords, srid: 4326}

    Repo.insert(%InterestPoint{event_type: type, location: location})
  end
end
