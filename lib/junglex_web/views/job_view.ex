defmodule JunglexWeb.JobView do
  use JunglexWeb, :view

  def render("index.json", %{jobs: jobs}) do
    jobs
  end
  def render("index.json", %{error: error}) do
    %{error: error}
  end  
  
end
