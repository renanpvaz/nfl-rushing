defmodule NflRushing.Records.Record do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:player_name, :team, :position, :rushing_attempts_per_game, :rushing_attempts, :total_rushing_yards, :avg_rushing_yards_per_attempt, :rushing_yards_per_game, :total_rushing_touchdowns, :rushing_first_downs, :rushing_first_down_percentage, :rushing_20_yards_plus_each, :rushing_40_yards_plus_each, :rushing_fumbles, :longest_rush]
  schema "records" do
    field :avg_rushing_yards_per_attempt, :float
    field :longest_rush, :string
    field :player_name, :string
    field :position, :string
    field :rushing_20_yards_plus_each, :float
    field :rushing_40_yards_plus_each, :float
    field :rushing_attempts, :float
    field :rushing_attempts_per_game, :float
    field :rushing_first_down_percentage, :float
    field :rushing_first_downs, :float
    field :rushing_fumbles, :float
    field :rushing_yards_per_game, :float
    field :team, :string
    field :total_rushing_touchdowns, :float
    field :total_rushing_yards, :float

    timestamps()
  end

  @doc false
  def changeset(record, attrs) do
    record
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
