defmodule NflRushingWeb.RecordControllerTest do
  use NflRushingWeb.ConnCase

  import NflRushing.RecordsFixtures

  alias NflRushing.Records.Record

  @create_attrs %{
    avg_rushing_yards_per_attempt: 120.5,
    longest_rush: "some longest_rush",
    player_name: "some player_name",
    position: "some position",
    rushing_20_yards_plus_each: 120.5,
    rushing_40_yards_plus_each: 120.5,
    rushing_attempts: 120.5,
    rushing_attempts_per_game: 120.5,
    rushing_first_down_percentage: 120.5,
    rushing_first_downs: 120.5,
    rushing_fumbles: 120.5,
    rushing_yards_per_game: 120.5,
    team: "some team",
    total_rushing_touchdowns: 120.5,
    total_rushing_yards: 120.5
  }
  @update_attrs %{
    avg_rushing_yards_per_attempt: 456.7,
    longest_rush: "some updated longest_rush",
    player_name: "some updated player_name",
    position: "some updated position",
    rushing_20_yards_plus_each: 456.7,
    rushing_40_yards_plus_each: 456.7,
    rushing_attempts: 456.7,
    rushing_attempts_per_game: 456.7,
    rushing_first_down_percentage: 456.7,
    rushing_first_downs: 456.7,
    rushing_fumbles: 456.7,
    rushing_yards_per_game: 456.7,
    team: "some updated team",
    total_rushing_touchdowns: 456.7,
    total_rushing_yards: 456.7
  }
  @invalid_attrs %{avg_rushing_yards_per_attempt: nil, longest_rush: nil, player_name: nil, position: nil, rushing_20_yards_plus_each: nil, rushing_40_yards_plus_each: nil, rushing_attempts: nil, rushing_attempts_per_game: nil, rushing_first_down_percentage: nil, rushing_first_downs: nil, rushing_fumbles: nil, rushing_yards_per_game: nil, team: nil, total_rushing_touchdowns: nil, total_rushing_yards: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all records", %{conn: conn} do
      conn = get(conn, Routes.record_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create record" do
    test "renders record when data is valid", %{conn: conn} do
      conn = post(conn, Routes.record_path(conn, :create), record: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.record_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "avg_rushing_yards_per_attempt" => 120.5,
               "longest_rush" => "some longest_rush",
               "player_name" => "some player_name",
               "position" => "some position",
               "rushing_20_yards_plus_each" => 120.5,
               "rushing_40_yards_plus_each" => 120.5,
               "rushing_attempts" => 120.5,
               "rushing_attempts_per_game" => 120.5,
               "rushing_first_down_percentage" => 120.5,
               "rushing_first_downs" => 120.5,
               "rushing_fumbles" => 120.5,
               "rushing_yards_per_game" => 120.5,
               "team" => "some team",
               "total_rushing_touchdowns" => 120.5,
               "total_rushing_yards" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.record_path(conn, :create), record: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update record" do
    setup [:create_record]

    test "renders record when data is valid", %{conn: conn, record: %Record{id: id} = record} do
      conn = put(conn, Routes.record_path(conn, :update, record), record: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.record_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "avg_rushing_yards_per_attempt" => 456.7,
               "longest_rush" => "some updated longest_rush",
               "player_name" => "some updated player_name",
               "position" => "some updated position",
               "rushing_20_yards_plus_each" => 456.7,
               "rushing_40_yards_plus_each" => 456.7,
               "rushing_attempts" => 456.7,
               "rushing_attempts_per_game" => 456.7,
               "rushing_first_down_percentage" => 456.7,
               "rushing_first_downs" => 456.7,
               "rushing_fumbles" => 456.7,
               "rushing_yards_per_game" => 456.7,
               "team" => "some updated team",
               "total_rushing_touchdowns" => 456.7,
               "total_rushing_yards" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, record: record} do
      conn = put(conn, Routes.record_path(conn, :update, record), record: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete record" do
    setup [:create_record]

    test "deletes chosen record", %{conn: conn, record: record} do
      conn = delete(conn, Routes.record_path(conn, :delete, record))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.record_path(conn, :show, record))
      end
    end
  end

  defp create_record(_) do
    record = record_fixture()
    %{record: record}
  end
end
