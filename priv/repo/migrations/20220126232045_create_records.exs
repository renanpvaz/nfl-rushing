defmodule NflRushing.Repo.Migrations.CreateRecords do
  use Ecto.Migration

  def change do
    create table(:records) do
      add :player_name, :string
      add :team, :string
      add :position, :string
      add :rushing_attempts_per_game, :float
      add :rushing_attempts, :float
      add :total_rushing_yards, :float
      add :avg_rushing_yards_per_attempt, :float
      add :rushing_yards_per_game, :float
      add :total_rushing_touchdowns, :float
      add :rushing_first_downs, :float
      add :rushing_first_down_percentage, :float
      add :rushing_20_yards_plus_each, :float
      add :rushing_40_yards_plus_each, :float
      add :rushing_fumbles, :float
      add :longest_rush, :string

      timestamps()
    end
  end
end
