defmodule RealtimeWeb.InterestPointController do
  use RealtimeWeb, :controller

  alias Realtime.InterestPoints

  def get_in_radius(conn, %{"id" => id, "radius" => radius}) do

    results = case InterestPoints.get_points_in_radius(iparse(id), iparse(radius)) do
    
      {:ok, res} -> res |> Enum.map(&(Map.from_struct(&1) |> Map.drop([:__meta__])))
      {:error, :not_found} -> %{error: "point with given id not found"}
    end

    json(conn, results)
  end

  def get_in_radius(conn, _) do
    conn
    |> json(%{
      error: "\"id\" and \"radius\" are required fields"
    })
  end
  
  def create(conn, %{"type" => type, "lng" => lng, "lat" => lat}) do
  
    coords = {fparse(lng), fparse(lat)}
    results = case InterestPoints.create_point(coords, iparse(type)) do
    
      {:ok, res} -> res |> Map.from_struct() |> Map.drop([:__meta__])
      {:error, _} -> %{error: "db error"}
    end

    json(conn, results)

  end

  def create(conn, _) do
    conn
    |> json(%{
      error: "\"type\", \"lng\" and \"lat\" are required fields"
    })
  end
  
  def fparse(str) when is_binary(str) do
  
    case Float.parse(str) do
    
      {f, _} -> f
      :error -> :error
    end
  end
  
  def fparse(n) when is_number(n), do: n
  
  def iparse(str) when is_binary(str), do: String.to_integer(str)
  
  def iparse(i) when is_integer(i), do: i
end

