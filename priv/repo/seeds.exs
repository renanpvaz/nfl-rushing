# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     NflRushing.Repo.insert!(%NflRushing.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias NflRushing.Records

json_file = "#{__DIR__}/data/rushing.json"

with {:ok, body} <- File.read(json_file),
     {:ok, json} <- Jason.decode(body) do 
  Enum.each(json, fn(rec) -> 
    Records.create_record(%{
    avg_rushing_yards_per_attempt:  Map.get(rec, "Avg"),
    longest_rush:  Map.get(rec, "Lng"),
    player_name:  Map.get(rec, "Player"),
    position:  Map.get(rec, "Pos"),
    rushing_20_yards_plus_each:  Map.get(rec, "20+"),
    rushing_40_yards_plus_each:  Map.get(rec, "40+"),
    rushing_attempts:  Map.get(rec, "Att"),
    rushing_attempts_per_game:  Map.get(rec, "Att/G"),
    rushing_first_down_percentage:  Map.get(rec, "1st%"),
    rushing_first_downs:  Map.get(rec, "1st"),
    rushing_fumbles:  Map.get(rec, "FUM"),
    rushing_yards_per_game:  Map.get(rec, "Yds/G"),
    team:  Map.get(rec, "Team"),
    total_rushing_touchdowns:  Map.get(rec, "TD"),
    total_rushing_yards:  Map.get(rec, "Yds")
    })
  end)
end
