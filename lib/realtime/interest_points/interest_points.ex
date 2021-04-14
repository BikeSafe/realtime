defmodule Realtime.InterestPoints do
  alias Realtime.{Repo, InterestPoints.InterestPoint}

  def get_points_in_radius(id, radius) do
    query =
      [
        "WITH target AS (SELECT location AS loc FROM interest_point WHERE id = $1)",
        "SELECT id, event_type, location FROM interest_point JOIN target ON true",
        "WHERE ST_DWithin(loc::geography, interest_point.location::geography, $2::double precision)"
      ]
      |> Enum.join(" ")

    # The arguments we are passing to the query
    args = [id, radius]

    # Since we used a raw SQL query, we'll need to manually (for more information
    # see https://hexdocs.pm/ecto_sql/Ecto.Adapters.SQL.html#query/4)
    case Repo.query(query, args, log: true) do
      {:ok, %Postgrex.Result{columns: cols, rows: rows}} ->
        results =
          Enum.map(rows, fn row ->
            Repo.load(InterestPoint, {cols, row})
          end)

        {:ok, results}

      _ ->
        {:error, :not_found}
    end
  end

  def create_point(coords, type) do
    location = %Geo.Point{coordinates: coords, srid: 4326}

    Repo.insert(%InterestPoint{event_type: type, location: location})
  end
end
