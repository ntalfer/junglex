defmodule Junglex.HereTest do
  use ExUnit.Case, async: true

  test "geolocation to country" do

    assert Junglex.Here.get_country(50.67, "50.89") == {:ok, "KAZ"}

    assert match?({:error, _}, Junglex.Here.get_country(0.0, 0.0))

  end

end
