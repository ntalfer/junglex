defmodule Junglex.CLI do

  @usage "Usage: ./junglex --j FICHIER_JOBS --p FICHIER_PROFESSIONS"
  
  def main(argv) do
    parsed = OptionParser.parse!(argv) |> elem(0)
    jobs_file = parsed[:j]
    categories_file = parsed[:p]
    cond do
     jobs_file == nil -> IO.puts(@usage)
     categories_file == nil -> IO.puts(@usage)
     true -> IO.inspect(Junglex.Exercise1.process(jobs_file, categories_file))
    end
  end
  
end