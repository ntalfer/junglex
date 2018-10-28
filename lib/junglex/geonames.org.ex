defmodule Junglex.Geonames do
  use Tesla
  require Logger

  @username "junglex"

  plug Tesla.Middleware.BaseUrl, "http://api.geonames.org"
  plug Tesla.Middleware.JSON

  def get_country(lat, long) when lat == "" or long == "" do
    {:error, "invalid lat/long"}
  end
  def get_country(lat, long) do
    case get("/countryCode?lat=#{lat}&lng=#{long}&username=#{@username}&type=json") do
      {:ok, %{body: %{"countryCode" => cc}}} ->
        {:ok, cc}
      {:ok, res} ->
        {:error, res.body}
      {:error, :socket_closed_remotely} ->
        get_country(lat, long)
      {:error, _} = error ->
        error
      error ->
        {:error, error}
    end
  end

end