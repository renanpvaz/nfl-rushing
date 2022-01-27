defmodule NflRushingWeb.RecordControllerTest do
  use NflRushingWeb.ConnCase

  import NflRushing.RecordsFixtures

  alias NflRushing.Records.Record

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all records", %{conn: conn} do
      conn = get(conn, Routes.record_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end
end
