defmodule NflRushing.Reports do
  import Ecto.Query

  alias NflRushing.Repo
  alias NflRushing.Records

  @column_names ~w(Name Team Pos Att/G Att Yds Avg Yds/G TD Lng 1st 1st% 20+ 40+ FUM)
  @columns ~w(player_name team position rushing_attempts_per_game rushing_attempts total_rushing_yards avg_rushing_yards_per_attempt rushing_yards_per_game total_rushing_touchdowns longest_rush rushing_first_downs rushing_first_down_percentage rushing_20_yards_plus_each rushing_40_yards_plus_each rushing_fumbles)a

  def generate(params, callback) do
    Repo.transaction(fn ->
      rows =
        Records.build_query(params)
        |> Repo.stream()
        |> Stream.map(&encode_row/1)

      Stream.uniq([@column_names])
      |> Stream.concat(rows)
      |> callback.()
    end)
  end

  defp encode_row(rec), do: Enum.map(@columns, &Map.get(rec, &1))
end
