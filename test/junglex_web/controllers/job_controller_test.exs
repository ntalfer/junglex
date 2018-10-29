defmodule JunglexWeb.JobControllerTest do
  use JunglexWeb.ConnCase

  test "jobs 10km around Dubaï", %{conn: conn} do

      params = %{"latitude" => "25.2048493",
      	         "longitude" => "55.2707828",
		 "radius" => "10"}
      response =
        conn
        |> get(job_path(conn, :index), params)
        |> json_response(200)

      expected = [%{"contract_type" => "TEMPORARY", "distance" => 0.0, "name" => "WEB / Graphic Designer", "office_latitude" => 25.2048493,
               "office_longitude" => 55.2707828, "profession_id" => 17},
             %{"contract_type" => "FULL_TIME", "distance" => 0.0, "name" => "[Parfums Christian Dior Orient] Head of Regional Controlling",
               "office_latitude" => 25.2048493, "office_longitude" => 55.2707828, "profession_id" => 24},
             %{"contract_type" => "FULL_TIME", "distance" => 0.0, "name" => "\"[SSC P&C UAE] Supply and Forecast Planner, Dubai\"",
               "office_latitude" => 25.2048493, "office_longitude" => 55.2707828, "profession_id" => 9},
             %{"contract_type" => "FULL_TIME", "distance" => 2.725932464965934,
               "name" => "[Givenchy] Sales Assistant position - Givenchy New Openings in Dubai!", "office_latitude" => 25.1912743,
               "office_longitude" => 55.2933428, "profession_id" => 31},
             %{"contract_type" => "TEMPORARY", "distance" => 0.0, "name" => "IT Manager ( Cluster )", "office_latitude" => 25.2048493,
               "office_longitude" => 55.2707828, "profession_id" => 17},
             %{"contract_type" => "FULL_TIME", "distance" => 0.0, "name" => "IT Director", "office_latitude" => 25.2048493,
               "office_longitude" => 55.2707828, "profession_id" => 17}]
	       
      assert response == expected
  end

  test "bad parameter", %{conn: conn} do
      params = %{"latitude" => "25.2048493",
      	         "longitude" => "55.2707828",
		 "radius" => "abcd"}
      response =
        conn
        |> get(job_path(conn, :index), params)
        |> json_response(400)

      assert response == %{"error" => "Parameter radius must be a valid float"}
  end

  test "missing parameter", %{conn: conn} do

      response =
        conn
        |> get(job_path(conn, :index))
        |> json_response(400)

      assert response == %{"error" => "one of the following parameters is missing: latitude, longitude, radius"}

  end

  test "swagger" do
    assert :ok == Mix.Task.run("phx.swagger.generate")
  end
  
end
