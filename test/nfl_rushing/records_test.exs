defmodule NflRushing.RecordsTest do
  use NflRushing.DataCase

  alias NflRushing.Records

  describe "records" do
    alias NflRushing.Records.Record

    import NflRushing.RecordsFixtures

    @invalid_attrs %{avg_rushing_yards_per_attempt: nil, longest_rush: nil, player_name: nil, position: nil, rushing_20_yards_plus_each: nil, rushing_40_yards_plus_each: nil, rushing_attempts: nil, rushing_attempts_per_game: nil, rushing_first_down_percentage: nil, rushing_first_downs: nil, rushing_fumbles: nil, rushing_yards_per_game: nil, team: nil, total_rushing_touchdowns: nil, total_rushing_yards: nil}

    test "list_records/0 returns all records" do
      record = record_fixture()
      assert Records.list_records() == [record]
    end

    test "get_record!/1 returns the record with given id" do
      record = record_fixture()
      assert Records.get_record!(record.id) == record
    end

    test "create_record/1 with valid data creates a record" do
      valid_attrs = %{avg_rushing_yards_per_attempt: 120.5, longest_rush: "some longest_rush", player_name: "some player_name", position: "some position", rushing_20_yards_plus_each: 120.5, rushing_40_yards_plus_each: 120.5, rushing_attempts: 120.5, rushing_attempts_per_game: 120.5, rushing_first_down_percentage: 120.5, rushing_first_downs: 120.5, rushing_fumbles: 120.5, rushing_yards_per_game: 120.5, team: "some team", total_rushing_touchdowns: 120.5, total_rushing_yards: 120.5}

      assert {:ok, %Record{} = record} = Records.create_record(valid_attrs)
      assert record.avg_rushing_yards_per_attempt == 120.5
      assert record.longest_rush == "some longest_rush"
      assert record.player_name == "some player_name"
      assert record.position == "some position"
      assert record.rushing_20_yards_plus_each == 120.5
      assert record.rushing_40_yards_plus_each == 120.5
      assert record.rushing_attempts == 120.5
      assert record.rushing_attempts_per_game == 120.5
      assert record.rushing_first_down_percentage == 120.5
      assert record.rushing_first_downs == 120.5
      assert record.rushing_fumbles == 120.5
      assert record.rushing_yards_per_game == 120.5
      assert record.team == "some team"
      assert record.total_rushing_touchdowns == 120.5
      assert record.total_rushing_yards == 120.5
    end

    test "create_record/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Records.create_record(@invalid_attrs)
    end

    test "update_record/2 with valid data updates the record" do
      record = record_fixture()
      update_attrs = %{avg_rushing_yards_per_attempt: 456.7, longest_rush: "some updated longest_rush", player_name: "some updated player_name", position: "some updated position", rushing_20_yards_plus_each: 456.7, rushing_40_yards_plus_each: 456.7, rushing_attempts: 456.7, rushing_attempts_per_game: 456.7, rushing_first_down_percentage: 456.7, rushing_first_downs: 456.7, rushing_fumbles: 456.7, rushing_yards_per_game: 456.7, team: "some updated team", total_rushing_touchdowns: 456.7, total_rushing_yards: 456.7}

      assert {:ok, %Record{} = record} = Records.update_record(record, update_attrs)
      assert record.avg_rushing_yards_per_attempt == 456.7
      assert record.longest_rush == "some updated longest_rush"
      assert record.player_name == "some updated player_name"
      assert record.position == "some updated position"
      assert record.rushing_20_yards_plus_each == 456.7
      assert record.rushing_40_yards_plus_each == 456.7
      assert record.rushing_attempts == 456.7
      assert record.rushing_attempts_per_game == 456.7
      assert record.rushing_first_down_percentage == 456.7
      assert record.rushing_first_downs == 456.7
      assert record.rushing_fumbles == 456.7
      assert record.rushing_yards_per_game == 456.7
      assert record.team == "some updated team"
      assert record.total_rushing_touchdowns == 456.7
      assert record.total_rushing_yards == 456.7
    end

    test "update_record/2 with invalid data returns error changeset" do
      record = record_fixture()
      assert {:error, %Ecto.Changeset{}} = Records.update_record(record, @invalid_attrs)
      assert record == Records.get_record!(record.id)
    end

    test "delete_record/1 deletes the record" do
      record = record_fixture()
      assert {:ok, %Record{}} = Records.delete_record(record)
      assert_raise Ecto.NoResultsError, fn -> Records.get_record!(record.id) end
    end

    test "change_record/1 returns a record changeset" do
      record = record_fixture()
      assert %Ecto.Changeset{} = Records.change_record(record)
    end
  end
end