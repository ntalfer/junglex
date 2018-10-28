defmodule Junglex.Exercise1Test do
  use ExUnit.Case, async: true
  
  test "exercise1" do

    jobs_file = Path.join([__DIR__, "technical-test-jobs.csv"])
    categories_file = Path.join([__DIR__, "technical-test-professions.csv"])

    IO.inspect Junglex.Exercise1.process(jobs_file, categories_file)

# API calls failing with geonames.org
# 13:55:34.676 [error] unable to find country code for job %{"contract_type" => "INTERNSHIP", "name" => "Stage - Business Developer - Lille", "office_latitude" => "", "office_longitude" => "", "profession_id" => "2"}: "invalid lat/long"
# 13:55:41.071 [error] unable to find country code for job %{"contract_type" => "FULL_TIME", "name" => "Client Executive Hong Kong", "office_latitude" => "22.2679685", "office_longitude" => "114.242536", "profession_id" => "2"}: %{"status" => %{"message" => "no country code found", "value" => 15}}
# 13:56:11.215 [error] unable to find country code for job %{"contract_type" => "TEMPORARY", "name" => "Aide soignant( H/F) CDD 3 mois Temps Complet ", "office_latitude" => "46.1436563", "office_longitude" => "6.1402594", "profession_id" => ""}: %{"status" => %{"message" => "no country code found", "value" => 15}}
# 13:56:16.048 [error] unable to find country code for job %{"contract_type" => "FULL_TIME", "name" => "Digital Excecutive", "office_latitude" => "8.0630539", "office_longitude" => "98.7460891", "profession_id" => "2"}: %{"status" => %{"message" => "no country code found", "value" => 15}}
# 13:56:36.109 [error] unable to find country code for job %{"contract_type" => "INTERNSHIP", "name" => "Digital Trader - Internship – Dubai - M/F", "office_latitude" => "25.2280866", "office_longitude" => "55.1732869", "profession_id" => "7"}: %{"status" => %{"message" => "no country code found", "value" => 15}}

# all can be found with here.com
#iex(12)> Junglex.Here.get_country("22.2679685","114.242536")                                     
#{:ok, "HKG"}
#iex(13)> Junglex.Here.get_country(46.1436563,6.1402594)     
#{:ok, "FRA"}
#iex(14)> Junglex.Here.get_country(8.0630539,98.7460891)
#{:ok, "THA"}
#iex(15)> Junglex.Here.get_country("25.2280866","55.1732869")
#{:ok, "ARE"}

  end

end