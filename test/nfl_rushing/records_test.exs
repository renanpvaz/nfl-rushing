defmodule NflRushing.RecordsTest do
  use NflRushing.DataCase

  alias NflRushing.Records

  describe "records" do
    alias NflRushing.Records.Record

    import NflRushing.RecordsFixtures

    @invalid_attrs %{
      avg_rushing_yards_per_attempt: nil,
      longest_rush: nil,
      player_name: nil,
      position: nil,
      rushing_20_yards_plus_each: nil,
      rushing_40_yards_plus_each: nil,
      rushing_attempts: nil,
      rushing_attempts_per_game: nil,
      rushing_first_down_percentage: nil,
      rushing_first_downs: nil,
      rushing_fumbles: nil,
      rushing_yards_per_game: nil,
      team: nil,
      total_rushing_touchdowns: nil,
      total_rushing_yards: nil,
      touchdown_on_longest_rush?: nil
    }

    test "list_records/0 with empty params returns all records" do
      record = record_fixture()
      assert Records.list_records().entries == [record]
    end

    test "list_records/0 should limit the amount of records returned" do
      for _ <- 0..30, do: record_fixture()
      result = Records.list_records()

      assert 30 > length(result.entries)
    end

    test "list_records/0 should return 25-record pages" do
      for _ <- 0..50, do: record_fixture()

      assert 25 == Records.list_records(%{"page" => 1}).entries |> length
      assert 25 == Records.list_records(%{"page" => 2}).entries |> length
    end

    test "list_records/0 with empty params returns all records sorted by total_rushing_yards desc as default" do
      record_fixture(%{total_rushing_yards: 999})
      record_fixture(%{total_rushing_yards: -1})
      record_fixture()
      result = Records.list_records()

      assert result.entries == Enum.sort_by(result.entries, & &1.total_rushing_yards, :desc)
    end

    test "list_records/1 ignores invalid sort params and disallowed fields using the default order instead" do
      record_fixture(%{total_rushing_yards: 999})
      record_fixture(%{total_rushing_yards: -1})
      record_fixture()
      result = Records.list_records()
      sorted_records = Enum.sort_by(result.entries, & &1.total_rushing_yards, :desc)

      assert sorted_records == Records.list_records(%{"foo" => "bar"}).entries
      assert sorted_records == Records.list_records(%{"sort" => "bar"}).entries

      assert sorted_records ==
               Records.list_records(%{"sort" => "total_rushing_yards:ascending"}).entries

      assert sorted_records ==
               Records.list_records(%{"sort" => "total_rushing_yards-asc"}).entries

      assert sorted_records == Records.list_records(%{"sort" => "player_name:desc"}).entries

      assert sorted_records ==
               Records.list_records(%{"sort" => "total_rushing_yards:asc,"}).entries

      assert sorted_records ==
               Records.list_records(%{"sort" => "total_rushing_yards:asc,longest_rush"}).entries
    end

    test "list_records/1 allows sorting records by total_rushing_touchdowns" do
      record_fixture(%{total_rushing_touchdowns: 999})
      record_fixture(%{total_rushing_touchdowns: -1})
      record_fixture()
      all = Records.list_records().entries
      asc = Records.list_records(%{"sort" => "total_rushing_touchdowns:asc"}).entries
      desc = Records.list_records(%{"sort" => "total_rushing_touchdowns:desc"}).entries

      assert asc == Enum.sort_by(all, & &1.total_rushing_touchdowns, :asc)
      assert desc == Enum.sort_by(all, & &1.total_rushing_touchdowns, :desc)
    end

    test "list_records/1 allows sorting records by longest_rush" do
      record_fixture(%{longest_rush: "999"})
      record_fixture(%{longest_rush: "0"})
      record_fixture()
      all = Records.list_records().entries
      asc = Records.list_records(%{"sort" => "longest_rush:asc"}).entries
      desc = Records.list_records(%{"sort" => "longest_rush:desc"}).entries

      assert asc == Enum.sort_by(all, & &1.longest_rush, :asc)
      assert desc == Enum.sort_by(all, & &1.longest_rush, :desc)
    end

    test "list_records/1 allows sorting by multiple fields" do
      record_fixture(%{total_rushing_touchdowns: 999, total_rushing_yards: 999})
      record_fixture(%{total_rushing_touchdowns: -1, total_rushing_yards: -1})
      record_fixture()
      all = Records.list_records().entries

      records =
        Records.list_records(%{"sort" => "total_rushing_touchdowns:desc,total_rushing_yards:desc"}).entries

      assert records ==
               Enum.sort_by(all, &[&1.total_rushing_yards, &1.total_rushing_touchdowns], :desc)
    end

    test "list_records/1 allows filtering records by player name" do
      record_fixture(%{player_name: "Matt"})
      record_fixture(%{player_name: "Matthew"})
      record_fixture()
      records = Records.list_records(%{"search" => "Mat"}).entries

      assert 2 == length(records)
    end

    test "list_records/1 filters by the whole player name" do
      record_fixture(%{player_name: "Matt"})
      record_fixture(%{player_name: "Matthew"})
      record_fixture()
      records = Records.list_records(%{"search" => "t"}).entries

      assert 2 == length(records)
    end

    test "get_record!/1 returns the record with given id" do
      record = record_fixture()
      assert Records.get_record!(record.id) == record
    end

    test "create_record/1 with valid data creates a record" do
      valid_attrs = %{
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
      }

      assert {:ok, %Record{} = record} = Records.create_record(valid_attrs)
      assert record.avg_rushing_yards_per_attempt == 120.5
      assert record.longest_rush == 85
      assert record.player_name == "some player_name"
      assert record.position == "some position"
      assert record.rushing_20_yards_plus_each == 120
      assert record.rushing_40_yards_plus_each == 120
      assert record.rushing_attempts == 120
      assert record.rushing_attempts_per_game == 120.5
      assert record.rushing_first_down_percentage == 120.5
      assert record.rushing_first_downs == 120
      assert record.rushing_fumbles == 120
      assert record.rushing_yards_per_game == 120.5
      assert record.team == "some team"
      assert record.total_rushing_touchdowns == 120
      assert record.total_rushing_yards == 120
      assert record.touchdown_on_longest_rush? == false
    end

    test "create_record/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Records.create_record(@invalid_attrs)
    end

    test "update_record/2 with valid data updates the record" do
      record = record_fixture()

      update_attrs = %{
        avg_rushing_yards_per_attempt: 456.7,
        longest_rush: 90,
        player_name: "some updated player_name",
        position: "some updated position",
        rushing_20_yards_plus_each: 456,
        rushing_40_yards_plus_each: 456,
        rushing_attempts: 456,
        rushing_attempts_per_game: 456.7,
        rushing_first_down_percentage: 456.7,
        rushing_first_downs: 456,
        rushing_fumbles: 456,
        rushing_yards_per_game: 456.7,
        team: "some updated team",
        total_rushing_touchdowns: 456,
        total_rushing_yards: 456,
        touchdown_on_longest_rush?: true
      }

      assert {:ok, %Record{} = record} = Records.update_record(record, update_attrs)
      assert record.avg_rushing_yards_per_attempt == 456.7
      assert record.longest_rush == 90
      assert record.player_name == "some updated player_name"
      assert record.position == "some updated position"
      assert record.rushing_20_yards_plus_each == 456
      assert record.rushing_40_yards_plus_each == 456
      assert record.rushing_attempts == 456
      assert record.rushing_attempts_per_game == 456.7
      assert record.rushing_first_down_percentage == 456.7
      assert record.rushing_first_downs == 456
      assert record.rushing_fumbles == 456
      assert record.rushing_yards_per_game == 456.7
      assert record.team == "some updated team"
      assert record.total_rushing_touchdowns == 456
      assert record.total_rushing_yards == 456
      assert record.touchdown_on_longest_rush? == true
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
