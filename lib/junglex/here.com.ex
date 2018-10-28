defmodule Junglex.Here do
  use Tesla
  require Logger

  @app_id "pmkpqINSAcBhwiK32vfB"
  @app_code "cCBFSTIQLq7JynHwFZQJZg"

  plug Tesla.Middleware.BaseUrl, "https://reverse.geocoder.api.here.com/6.2"
  plug Tesla.Middleware.JSON

  def get_country(lat, long) when lat == "" or long == "" do
    {:error, "invalid lat/long"}
  end
  def get_country(lat, long) do
    case get("/reversegeocode.json?prox=#{lat}%2C#{long}&mode=retrieveAddresses&app_id=#{@app_id}&app_code=#{@app_code}&gen=9&maxresults=1") do
      {:ok, %{body: body}} ->
        cc =
	body
	|> get_in(["Response", "View"])
	|> Enum.at(0)
	|> get_in(["Result"])
	|> Enum.at(0)
	|> get_in(["Location", "Address", "Country"])
        {:ok, cc}
      {:error, :socket_closed_remotely} ->
        get_country(lat, long)
      {:error, _} = error ->
        error
      error ->
        {:error, error}
    end
  end

end