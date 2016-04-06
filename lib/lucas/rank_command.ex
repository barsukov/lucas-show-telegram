defmodule Lucas.RankCommand do
  use HTTPoison.Base
  require Logger
  alias TableRex.Table

  @expected_fields ~w( standing )

  def process_url(_) do
    "http://api.football-data.org/v1/soccerseasons/398/leagueTable"
  end

  def get_rank() do
    result = get!("/").body[:standing]
    title = "EPL TABLE"
    header = ["Team", "Points", "Played Games"]
    rows = Enum.map(result, fn (element) ->
      [ element["teamName"] , element["points"], element["playedGames"]]
    end)
    Table.new(rows, header, title)
    |> Table.put_column_meta(0..2, align: :left, padding: 1) # `0..2` is a range of column indexes. :all also works.
    |> Table.render!()
  end

  def format_table(collection) do
    Table.format(collection, padding: 1) |> IO.puts
  end

  def process_response_body(body) do
     body
     |> Poison.decode!
     |> Dict.take(@expected_fields)
     |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end
