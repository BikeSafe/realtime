defmodule Realtime.InterestPoints.InterestPoint do
  @moduledoc """
  Schema to define interest point entries
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias __MODULE__

  schema "interest_point" do
    field :event_type, :integer
    field :location, Geo.PostGIS.Geometry
  end

  def changeset(%InterestPoint{} = interest_point, attrs \\ %{}) do
    all_fields = [:event_type, :location]

    interest_point
    |> cast(attrs, all_fields)
    |> validate_required(all_fields)
  end
end
