defmodule NflRushing.RecordsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `NflRushing.Records` context.
  """

  @doc """
  Generate a record.
  """
  def record_fixture(attrs \\ %{}) do
    {:ok, record} =
      attrs
      |> Enum.into(%{
        avg_rushing_yards_per_attempt: 120.5,
        longest_rush: 85,
        player_name: "some player_name",
        position: "some position",
        rushing_20_yards_plus_each: 120,
        rushing_40_yards_plus_each: 120,
        rushing_attempts: 120,
        rushing_attempts_per_game: 120.5,
        rushing_first_down_percentage: 120.5,
        rushing_first_downs: 120,
        rushing_fumbles: 120,
        rushing_yards_per_game: 120.5,
        team: "some team",
        total_rushing_touchdowns: 120,
        total_rushing_yards: 120,
        touchdown_on_longest_rush?: false
      })
      |> NflRushing.Records.create_record()

    record
  end
end
