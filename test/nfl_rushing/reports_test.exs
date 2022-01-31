defmodule NflRushing.ReportsTest do
  use NflRushing.DataCase

  alias NflRushing.Reports

  @column_names ~w(Name Team Pos Att/G Att Yds Avg Yds/G TD Lng 1st 1st% 20+ 40+ FUM)

  describe "reports" do
    import NflRushing.RecordsFixtures

    test "generate/2 streams CSV-ready data" do
      record_fixture()
      record_fixture()

      Reports.generate(%{}, fn stream ->
        assert Enum.take(stream, 2) == [
          @column_names,
          [
            "some player_name",
            "some team",
            "some position",
            120.5,
            120.5,
            120.5,
            120.5,
            120.5,
            120.5,
            "some longest_rush",
            120.5,
            120.5,
            120.5,
            120.5,
            120.5
          ]
        ]
      end)
    end

    test "generate/2 makes use of all available data" do
      for _ <- 1..30, do: record_fixture()

      Reports.generate(%{}, fn stream ->
        assert 25 < Enum.count(stream)
      end)
    end

    test "generate/2 accepts sorting params" do
      record_fixture()
      record_fixture()
      record_fixture(%{player_name: "target", total_rushing_yards: -1})
      record_fixture()

      Reports.generate(%{"sort" => "total_rushing_yards:asc"}, fn stream ->
        assert "target" == Enum.at(stream, 1) |> Enum.at(0)
      end)
    end

    test "generate/2 allows using filtered results" do
      record_fixture()
      record_fixture()
      record_fixture(%{player_name: "target"})
      record_fixture()

      Reports.generate(%{"search" => "target"}, fn stream ->
        assert 2 == Enum.count(stream)
      end)
    end
  end
end
