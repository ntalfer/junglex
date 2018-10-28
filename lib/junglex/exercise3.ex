defmodule Junglex.Exercise3 do

  alias Junglex.CSV
  require Logger
  
  @jobs_file Path.join([__DIR__, "technical-test-jobs.csv"])

  def process(lat, long, radius) do
    with {{:ok, latf}, _} <- {to_float(lat), "latitude"},
         {{:ok, longf}, _} <- {to_float(long), "longitude"},
	 {{:ok, radiusf}, _} <- {to_float(radius), "radius"}  do
    @jobs_file
    |> CSV.decode(true)
    |> Stream.flat_map(fn job -> filter(job, latf, longf, radiusf) end)
    |> Enum.to_list
    else
      {_error, param} -> {:error, "Parameter #{param} must be a valid float"}
    end    
  end

  defp filter(%{"office_latitude" => lat,
                "office_longitude" => long}, _, _, _)
  when lat == "" or long == "" do
    []
  end
  defp filter(job, lat, long, radius) do
    office = [to_float(job["office_latitude"]) |> elem(1),
              to_float(job["office_longitude"]) |> elem(1)]
    point = [lat, long]
    distance = Geocalc.distance_between(office, point)
    if distance <= radius do
      [Map.put(job, "distance", distance)]
    else
      []
    end
  end  

  defp to_float(str) when is_bitstring(str) do
    case Float.parse(str) do
      :error -> :error
      {f, _} -> {:ok, f}
    end
  end
  defp to_float(f) when is_float(f) or is_integer(f), do: {:ok, f}
  defp to_float(_), do: :error
  
end