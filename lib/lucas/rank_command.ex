defmodule Lucas.RankCommand do
  use HTTPoison.Base
  require Logger
  alias TableRex.Table

  @expected_fields ~w( standing )

  def process_url(_) do
    "http://api.football-data.org/v1/competitions/426/leagueTable"
  end

  def get_rank() do
    result = get!("/").body[:standing]
    header = ["N", "Team", "Pts", "PG"]
    rows = Enum.map(result, fn (element) ->
      [ element["position"], String.slice(element["teamName"], 0..12), element["points"], element["playedGames"]]
    end)
    TableRex.quick_render!(rows, header)
  end

  def process_response_body(body) do
     body
     |> Poison.decode!
     |> Dict.take(@expected_fields)
     |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end
