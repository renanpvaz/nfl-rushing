defmodule NflRushingWeb.RecordView do
  use NflRushingWeb, :view
  alias NflRushingWeb.RecordView

  def render("index.json", %{records: records}) do
    %{data: render_many(records, RecordView, "record.json")}
  end

  def render("show.json", %{record: record}) do
    %{data: render_one(record, RecordView, "record.json")}
  end

  def render("record.json", %{record: record}) do
    %{
      id: record.id,
      player_name: record.player_name,
      team: record.team,
      position: record.position,
      rushing_attempts_per_game: record.rushing_attempts_per_game,
      rushing_attempts: record.rushing_attempts,
      total_rushing_yards: record.total_rushing_yards,
      avg_rushing_yards_per_attempt: record.avg_rushing_yards_per_attempt,
      rushing_yards_per_game: record.rushing_yards_per_game,
      total_rushing_touchdowns: record.total_rushing_touchdowns,
      rushing_first_downs: record.rushing_first_downs,
      rushing_first_down_percentage: record.rushing_first_down_percentage,
      rushing_20_yards_plus_each: record.rushing_20_yards_plus_each,
      rushing_40_yards_plus_each: record.rushing_40_yards_plus_each,
      rushing_fumbles: record.rushing_fumbles,
      longest_rush: record.longest_rush
    }
  end
end
