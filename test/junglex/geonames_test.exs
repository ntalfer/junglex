defmodule Junglex.GeonamesTest do
  use ExUnit.Case, async: true
  
  test "geolocation to country" do

    assert Junglex.Geonames.get_country(50.67, "50.89") == {:ok, "KZ"}
	   
    assert match?({:error, _}, Junglex.Geonames.get_country(0.0, 0.0))
    
  end

end