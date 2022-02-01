defmodule NflRushing.Repo.Migrations.CreateRecords do
  use Ecto.Migration

  def change do
    create table(:records) do
      add :player_name, :string
      add :team, :string
      add :position, :string
      add :rushing_attempts_per_game, :float
      add :rushing_attempts, :integer
      add :total_rushing_yards, :integer
      add :avg_rushing_yards_per_attempt, :float
      add :rushing_yards_per_game, :float
      add :total_rushing_touchdowns, :integer
      add :rushing_first_downs, :integer
      add :rushing_first_down_percentage, :float
      add :rushing_20_yards_plus_each, :integer
      add :rushing_40_yards_plus_each, :integer
      add :rushing_fumbles, :integer
      add :longest_rush, :integer
      add :touchdown_on_longest_rush?, :boolean

      timestamps()
    end
  end
end
