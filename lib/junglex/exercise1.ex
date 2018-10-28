defmodule Junglex.Exercise1 do

  alias Junglex.{CSV, Geocoding}
  require Logger
  
  # need to add this category as some jobs have no profession id
  @divers %{"id" => "", "name" => "Divers", "category_name" => "Divers"}

def process(jobs_file, categories_file) do

    Cachex.start_link(:my_cache, [])
    Cachex.put(:my_cache, "api_calls", 0)
    
    categories =
      categories_file
      |> CSV.decode
      |> Kernel.++([@divers])
      
    categories_counter =
      categories
      |> Enum.map(&({&1["category_name"], 0})) 
      |> Enum.into(%{})
      
    continents_counter = 
      Junglex.Geocoding.continents()
      |> Enum.map(&({&1, categories_counter}))
      |> Enum.into(%{})

    res = 
    jobs_file
    |> CSV.decode(true)
    |> Task.async_stream(&job_with_continent/1)
    |> Stream.map(fn {:ok, res} -> res end)
    |> Stream.map(&(job_with_category(&1, categories)))
    |> Enum.to_list
    |> Enum.reduce(continents_counter, fn job, counter ->
       continent = job["continent"]
       category = job["category_name"]
       continent_counter = counter[continent]
       category_counter = continent_counter[category]
       %{counter | continent => %{continent_counter | category => category_counter+1}}
    end)
    
    #IO.inspect "api_calls=#{inspect Cachex.get(:my_cache, "api_calls")}"

    res
  end

  defp job_with_continent(job) do
    cache_key = "#{job["office_latitude"]},#{job["office_longitude"]}"
    case Cachex.get(:my_cache, cache_key) do
    {:ok, nil} ->
    continent = 
       #Junglex.Geonames.get_country(job["office_latitude"], job["office_longitude"])
       Junglex.Here.get_country(job["office_latitude"], job["office_longitude"])
       |> case do
         {:error, error} ->
	     Logger.error "unable to find country code for job #{inspect job}: #{inspect error}"
	     nil
	 {:ok, code} ->
	    code
       end
       |> Geocoding.continent
       Cachex.put(:my_cache, cache_key, continent)
       Cachex.incr(:my_cache, "api_calls", 1)
       Map.put(job, "continent", continent)
     {:ok, continent} ->
       Map.put(job, "continent", continent)
     end
  end

  defp job_with_category(job, categories) do
    category =
      categories
      |> Enum.find(&(&1["id"] == job["profession_id"]))
    Map.put(job, "category_name", category["category_name"])
  end
  
end