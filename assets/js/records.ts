import { useEffect, useMemo, useState } from "react";

export type RushingRecord = {
  id: number;
  avg_rushing_yards_per_attempt: number;
  longest_rush: string;
  player_name: string;
  position: string;
  rushing_20_yards_plus_each: number;
  rushing_40_yards_plus_each: number;
  rushing_attempts: number;
  rushing_attempts_per_game: number;
  rushing_first_down_percentage: number;
  rushing_first_downs: number;
  rushing_fumbles: number;
  rushing_yards_per_game: number;
  team: string;
  total_rushing_touchdowns: number;
  total_rushing_yards: number;
};

export type SortableField =
  | "total_rushing_yards"
  | "total_rushing_touchdowns"
  | "longest_rush";

export type OrderState = Partial<
  Record<SortableField, "asc" | "desc" | undefined>
>;

type SetParams = (patch: Partial<Params>) => void;

const buildQuery = ({ order, page, pageSize, search }: Params) => {
  const sort = Object.entries(order)
    .map(([k, v]) => `${k}:${v}`)
    .join(",");
  const params = Object.assign(
    { page: `${page}`, page_size: `${pageSize}` },
    search && { search },
    sort.length && { sort }
  );

  return new URLSearchParams(params).toString();
};

type PageSize = 25 | 50 | 100;

type State = {
  records: RushingRecord[];
  params: Params;
  query: string;
  totalPages: number;
};

type Params = {
  page: number;
  order: OrderState;
  search: string;
  pageSize: PageSize;
};

const isValidPageSize = (value: any): value is PageSize =>
  [25, 50, 100].includes(parseInt(value));

const useRecords = (): [State, SetParams] => {
  const [records, setRecords] = useState<RushingRecord[]>([]);
  const [totalPages, setTotalPages] = useState(0);
  const [params, setQuery] = useState<Params>({
    page: 1,
    search: "",
    pageSize: 25,
    order: {
      total_rushing_yards: "desc",
    },
  });
  const query = useMemo(() => buildQuery(params), [params]);
  const state = useMemo(
    () => ({ query, params, records, totalPages }),
    [query, records, params, totalPages]
  );

  const updateParams: SetParams = (patch) => {
    setQuery({ ...params, ...patch });
  };

  useEffect(() => {
    fetch(`http://localhost:4000/api/records?${query}`)
      .then((res) => res.json())
      .then((res) => {
        setRecords(res.data);
        setTotalPages(res.total_pages);
      });
  }, [query]);

  return [state, updateParams];
};

export { useRecords, isValidPageSize };
