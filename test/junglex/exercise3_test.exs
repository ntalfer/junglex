defmodule Junglex.Exercise3Test do
  use ExUnit.Case, async: true
  
  test "jobs 10km around Dubaï" do
    expected = [%{"contract_type" => "TEMPORARY", "distance" => 0.0,
   "name" => "WEB / Graphic Designer", "office_latitude" => "25.2048493",
   "office_longitude" => "55.2707828", "profession_id" => "17"},
 %{"contract_type" => "FULL_TIME", "distance" => 0.0,
   "name" => "[Parfums Christian Dior Orient] Head of Regional Controlling",
   "office_latitude" => "25.2048493", "office_longitude" => "55.2707828",
   "profession_id" => "24"},
 %{"contract_type" => "FULL_TIME", "distance" => 0.0,
   "name" => "\"[SSC P&C UAE] Supply and Forecast Planner, Dubai\"",
   "office_latitude" => "25.2048493", "office_longitude" => "55.2707828",
   "profession_id" => "9"},
 %{"contract_type" => "FULL_TIME", "distance" => 2.725932464965934,
   "name" => "[Givenchy] Sales Assistant position - Givenchy New Openings in Dubai!",
   "office_latitude" => "25.1912743", "office_longitude" => "55.2933428",
   "profession_id" => "31"},
 %{"contract_type" => "TEMPORARY", "distance" => 0.0,
   "name" => "IT Manager ( Cluster )", "office_latitude" => "25.2048493",
   "office_longitude" => "55.2707828", "profession_id" => "17"},
 %{"contract_type" => "FULL_TIME", "distance" => 0.0, "name" => "IT Director",
   "office_latitude" => "25.2048493", "office_longitude" => "55.2707828",
   "profession_id" => "17"}]

    assert Junglex.Exercise3.process(25.2048493, 55.2707828, 10) == expected
  end
  
  test "jobs 1km around Dubaï" do

    # Givenchy job does not match
    
    expected = [%{"contract_type" => "TEMPORARY", "distance" => 0.0,
   "name" => "WEB / Graphic Designer", "office_latitude" => "25.2048493",
   "office_longitude" => "55.2707828", "profession_id" => "17"},
 %{"contract_type" => "FULL_TIME", "distance" => 0.0,
   "name" => "[Parfums Christian Dior Orient] Head of Regional Controlling",
   "office_latitude" => "25.2048493", "office_longitude" => "55.2707828",
   "profession_id" => "24"},
 %{"contract_type" => "FULL_TIME", "distance" => 0.0,
   "name" => "\"[SSC P&C UAE] Supply and Forecast Planner, Dubai\"",
   "office_latitude" => "25.2048493", "office_longitude" => "55.2707828",
   "profession_id" => "9"},
 %{"contract_type" => "TEMPORARY", "distance" => 0.0,
   "name" => "IT Manager ( Cluster )", "office_latitude" => "25.2048493",
   "office_longitude" => "55.2707828", "profession_id" => "17"},
 %{"contract_type" => "FULL_TIME", "distance" => 0.0, "name" => "IT Director",
   "office_latitude" => "25.2048493", "office_longitude" => "55.2707828",
   "profession_id" => "17"}]

    assert Junglex.Exercise3.process(25.2048493,55.2707828, 1) == expected
  end

  test "wrong parameter" do
    assert Junglex.Exercise3.process(0.0, 0.0, "abcd") == {:error, "Parameter radius must be a valid float"}
  end
end