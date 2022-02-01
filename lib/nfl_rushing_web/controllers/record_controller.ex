defmodule NflRushingWeb.RecordController do
  use NflRushingWeb, :controller

  alias NflRushing.Records

  action_fallback NflRushingWeb.FallbackController

  def index(conn, params) do
    records = Records.list_records(params)
    render(conn, "index.json", records: records)
  end
end
