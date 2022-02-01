defmodule NflRushingWeb.ReportController do
  use NflRushingWeb, :controller

  alias NimbleCSV.RFC4180, as: CSV

  def index(conn, params) do
    conn =
      conn
      |> put_resp_content_type("text/csv")
      |> put_resp_header("content-disposition", ~s[attachment; filename="rushing.csv"])
      |> send_chunked(:ok)

    NflRushing.Reports.generate(params, fn stream ->
      for row <- stream do
        csv_rows = CSV.dump_to_iodata([row])
        conn |> chunk(csv_rows)
      end
    end)

    conn
  end
end
