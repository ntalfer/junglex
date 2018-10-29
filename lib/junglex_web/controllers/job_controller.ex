defmodule JunglexWeb.JobController do
  use JunglexWeb, :controller
  use PhoenixSwagger
  
def swagger_definitions do
  %{
    Job: swagger_schema do
      title "Job"
      description "A job"
      properties do
        contract_type :string, "the contract type"
        distance :float, "the distance in kilometers between the job office and the requested geolocation"
        name :string, "the job name"
	office_latitude :float, "the office latitude"
        office_longitude :float, "the office longitude"
        profession_id :integer, "the profession id"
      end
      example %{
        contract_type: "TEMPORARY", 
        distance: 10, 
        name: "WEB / Graphic Designer", 
        office_latitude: 25.2048493,
        office_longitude: 55.2707828, 
        profession_id: 17        
      }
    end,
    Jobs: swagger_schema do
      title "Jobs"
      description "A collection of jobs"
      type :array
      items Schema.ref(:Job)
    end
  }
  end

  swagger_path :index do
    get "/api/jobs"
    description "List job offers within a given radius from a given latitude and longitude"
  parameters do
    latitude :query, :float, "the latitude of the point", required: true, example: 25.2048493
    longitude :query, :float, "the longitude of the point", required: true, example: 55.2707828
    radius :query, :float, "the radius in kilometers", required: true, example: 10
  end
   response 200, "Success", Schema.ref(:Jobs)
    response 400, "Bad request"
  end

  def index(conn, %{"latitude" => latitude,
                    "longitude" => longitude,
		    "radius" => radius}) do
    with jobs when is_list(jobs) <- Junglex.Exercise3.process(latitude, longitude, radius) do
      conn
      |> put_status(:ok)
      |> render("index.json", %{jobs: jobs})
    else {:error, error} ->
      conn
      |> put_status(:bad_request)
      |> render("index.json", %{error: error})      
    end
    
  end
  def index(conn, _) do
      conn
      |> put_status(:bad_request)
      |> render("index.json", %{error: "one of the following parameters is missing: latitude, longitude, radius"})    
  end
  
end
