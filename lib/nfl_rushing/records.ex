defmodule NflRushing.Records do
  @moduledoc """
  The Records context.
  """

  import Ecto.Query, warn: false
  alias NflRushing.Repo

  alias NflRushing.Records.Record

  @sortable_fields ["total_rushing_yards", "longest_rush", "total_rushing_touchdowns"]
  @default_order [desc: :total_rushing_yards]

  @doc """
  Returns the list of records.

  ## Examples

      iex> list_records()
      [%Record{}, ...]

  """
  def list_records(params \\ %{}) do
    Record
    |> apply_filter(params)
    |> apply_sort(params)
    |> Repo.all()
  end

  defp apply_filter(query, %{"search" => search}) do
    where(query, [r], ilike(r.player_name, ^"%#{String.replace(search, "%", "\\%")}%"))
  end

  defp apply_filter(query, _), do: query

  defp apply_sort(query, %{"sort" => sort}) do
    order = String.split(sort, ",") |> parse_order
    order_by(query, ^order)
  end

  defp apply_sort(query, _), do: order_by(query, ^@default_order)

  defp parse_order([]), do: []

  defp parse_order([param | rest]) do
    case String.split(param, ":") do
      [field, order] when field in @sortable_fields and order in ["asc", "desc"] ->
        [{String.to_existing_atom(order), String.to_existing_atom(field)} | parse_order(rest)]

      _ ->
        @default_order
    end
  end

  @doc """
  Gets a single record.

  Raises `Ecto.NoResultsError` if the Record does not exist.

  ## Examples

      iex> get_record!(123)
      %Record{}

      iex> get_record!(456)
      ** (Ecto.NoResultsError)

  """
  def get_record!(id), do: Repo.get!(Record, id)

  @doc """
  Creates a record.

  ## Examples

      iex> create_record(%{field: value})
      {:ok, %Record{}}

      iex> create_record(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_record(attrs \\ %{}) do
    %Record{}
    |> Record.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a record.

  ## Examples

      iex> update_record(record, %{field: new_value})
      {:ok, %Record{}}

      iex> update_record(record, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_record(%Record{} = record, attrs) do
    record
    |> Record.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a record.

  ## Examples

      iex> delete_record(record)
      {:ok, %Record{}}

      iex> delete_record(record)
      {:error, %Ecto.Changeset{}}

  """
  def delete_record(%Record{} = record) do
    Repo.delete(record)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking record changes.

  ## Examples

      iex> change_record(record)
      %Ecto.Changeset{data: %Record{}}

  """
  def change_record(%Record{} = record, attrs \\ %{}) do
    Record.changeset(record, attrs)
  end
end
