defmodule Junglex.Geocoding do

  @external_resource csv_path = Path.join([__DIR__, "iso-3166.csv"])
  
  require Logger

  @eu "Europe"
  @am "Amérique"
  @as "Asie"
  @af "Afrique"
  @oc "Océanie"
  @an "Antarctique"
  @unknown "Inconnu"
  @continents [@eu, @am, @as, @af, @oc, @an, @unknown] 

  csv_path
  |> File.stream!
  |> Stream.drop(1) # skip the 1st line of the file (column names)
  |> Stream.each(fn line ->      
       [_, alpha2, alpha3, _, _, region | _] = String.split(line, [",", "\n"], trim: true)
       def continent(unquote(alpha2)), do: to_fr(unquote(region))
       def continent(unquote(alpha3)), do: to_fr(unquote(region))
  end)
  |> Stream.run

  # default clause
  def continent(_country_code) do
      #Logger.error "country code #{inspect country_code} doesn't match any continent"
      @unknown
  end

  def continents(), do: @continents

  defp to_fr("Europe"), do: @eu
  defp to_fr("Americas"), do: @am
  defp to_fr("Asia"), do: @as
  defp to_fr("Oceania"), do: @as
  defp to_fr("Africa"), do: @af
  defp to_fr("Antarctica"), do: @an
  defp to_fr(""), do: @unknown
end