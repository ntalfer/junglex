defmodule Junglex.GeocodingTest do
  use ExUnit.Case, async: true
  
  test "country code to continent" do
    assert Junglex.Geocoding.continent("FR") == "Europe"
    assert Junglex.Geocoding.continent("US") == "Amérique du Nord"
    assert Junglex.Geocoding.continent("BR") == "Amérique du Sud"
    assert Junglex.Geocoding.continent("JP") == "Asie"
    assert Junglex.Geocoding.continent("ZA") == "Afrique"
    assert Junglex.Geocoding.continent("NZ") == "Océanie"
    assert Junglex.Geocoding.continent("ZZ") == "Inconnu"
  end

end