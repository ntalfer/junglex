defmodule JunglexWeb.JobView do
  use JunglexWeb, :view

  def render("index.json", %{jobs: jobs}) do
    render_many(jobs, __MODULE__, "job.json")
  end
  def render("job.json", %{job: job}) do
    job
    |> Enum.map(fn({k, v}) when k in ["office_latitude", "office_longitude"] -> {k, to_float(v)}
                  ({"profession_id", v}) -> {"profession_id", to_int(v)}
                  ({k, v}) -> {k, v}
		end)
    |> Enum.into(%{})
  end  
  def render("index.json", %{error: error}) do
    %{error: error}
  end

  defp to_float(str) when is_bitstring(str) do
    case Float.parse(str) do
      :error -> str
      {f, _} -> f
    end
  end
  defp to_float(f) when is_float(f) or is_integer(f), do: f
  defp to_float(other), do: other

  defp to_int(str) when is_bitstring(str) do
    case Integer.parse(str) do
      :error -> str
      {i, _} -> i
    end
  end
  defp to_int(other), do: other
  
end
