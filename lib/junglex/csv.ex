defmodule Junglex.CSV do

  def decode(file, as_stream \\ false) do
    stream =
      file
      |> File.stream!
      |> Stream.transform(nil, &parse_line/2)
    if as_stream do
      stream
    else
      Enum.to_list(stream)
    end
  end

  defp parse_line(line, nil) do
    # csv 1st line, get keys
    keys = String.split(line, [",", "\n"], trim: true)
    {[], keys}
  end
  defp parse_line(line, keys) do
    # use Regex.scan/2 instead of String.split/2 as some fields may be
    # surrounded by double quotes and contain commas
    # example: 31,FULL_TIME,"[Louis Vuitton North America] Team Manager, RTW - NYC",40.7630463,-73.973527\n
    # some fields may also be empty
    line = String.trim_trailing(line, "\n")
    values = Regex.scan(~r/".*",|[^,]*,/, line <> ",")
	  |> Enum.flat_map(&(&1))
	  |> Enum.map(&(String.trim_trailing(&1, ",")))
    item = Enum.zip(keys, values) |> Enum.into(%{})
    {[item], keys}
  end

end
