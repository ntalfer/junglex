defmodule Junglex.CLI do
  
  @usage "Usage: ./junglex --j FICHIER_JOBS --p FICHIER_PROFESSIONS"
  
  def main(argv) do
    parsed = OptionParser.parse!(argv) |> elem(0)
    jobs_file = parsed[:j]
    categories_file = parsed[:p]
    cond do
     (jobs_file == nil) or (categories_file == nil) ->
       IO.puts(@usage)
     true ->
       Junglex.Exercise1.process(jobs_file, categories_file)
       |> print_table()
    end
  end

  defp print_table(data) do
    categories = data |> Enum.at(0) |> elem(1) |> Map.keys()
    header = ["", "Total"] ++ categories
    rows = data
    |> Enum.map(fn {k, v} -> [k] ++ [Enum.reduce(v, 0, fn {_ , v}, acc -> acc + v end)] ++ Enum.map(v, fn {_, v} -> v end) end)
    total_row = ["Total"] ++
      (rows
      |> Enum.map(&(Enum.drop(&1, 1)))
      |> Enum.reduce(fn row, acc ->
      acc
      |> Enum.with_index()
      |> Enum.map(fn {v, idx} -> v + Enum.at(row, idx) end)
    end))
    TableRex.Table.new([total_row] ++ rows, header)
    |> TableRex.Table.render!(horizontal_style: :all)
    |> IO.puts
  end
end