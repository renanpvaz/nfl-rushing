defmodule NflRushing.ReportsTest do
  use NflRushing.DataCase

  alias NflRushing.Records
  alias NflRushing.Reports

  @column_names ~w(Name Team Pos Att/G Att Yds Avg Yds/G TD Lng 1st 1st% 20+ 40+ FUM)

  describe "reports" do
    alias NflRushing.Records.Record

    import NflRushing.RecordsFixtures

    test "generate/2 2" do
      rec = record_fixture()

      Reports.generate(%{}, fn stream ->
        Enum.take(stream, 1) == [
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
  end
end
