import "../css/app.css";

import React, { useEffect, useState } from "react";
import ReactDOM from "react-dom";

type RushingRecord = {
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

type SortableField =
  | "total_rushing_yards"
  | "total_rushing_touchdowns"
  | "longest_rush";

type OrderState = Partial<Record<SortableField, "asc" | "desc" | undefined>>;

const SortableColumnHeader: React.FC<{
  field: SortableField;
  label: string;
  onToggle: (f: SortableField) => void;
  sorting: OrderState;
}> = ({ field, label, onToggle, sorting }) => (
  <button
    className="record__header-cell clickable"
    onClick={() => onToggle(field)}
  >
    {field in sorting ? (sorting[field] === "asc" ? "↑" : "↓") : "-"} {label}
  </button>
);

const omit = <T, K extends keyof T>(key: K, obj: T): Omit<T, K> => {
  const { [key]: _, ...rest } = obj;
  return rest;
};

const App: React.FC = () => {
  const [records, setRecords] = useState<RushingRecord[]>([]);
  const [search, setSearch] = useState("");
  const [order, setOrder] = useState<OrderState>({
    total_rushing_yards: "desc",
  });

  useEffect(() => {
    const sort = Object.entries(order)
      .map(([k, v]) => `${k}:${v}`)
      .join(",");

    fetch(`http://localhost:4000/api/records?sort=${sort}&search=${search}`)
      .then((res) => res.json())
      .then((res) => setRecords(res.data));
  }, [search, order]);

  const handleSort = (field: SortableField) => {
    const value = order[field];

    setOrder(
      value === "asc"
        ? omit(field, order)
        : {
            ...order,
            [field]: !value ? "desc" : "asc",
          }
    );
  };

  return (
    <div className="content">
      <header className="heading">
        <h1>🏈 NFL Rushing</h1>
        <div>
          <button className="button clickable">📄 export</button>
          <input
            className="search"
            type="search"
            placeholder="Player search"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
          />
        </div>
      </header>
      <ul className="records">
        <li className="record record--header">
          <span className="record__header-cell">Name</span>
          <span className="record__header-cell">Team</span>
          <span className="record__header-cell">Pos</span>
          <span className="record__header-cell">Att/G</span>
          <span className="record__header-cell">Att</span>
          <SortableColumnHeader
            label="Yds"
            field="total_rushing_yards"
            sorting={order}
            onToggle={handleSort}
          />
          <span className="record__header-cell">Avg</span>
          <span className="record__header-cell">Yds/G</span>
          <SortableColumnHeader
            label="TD"
            field="total_rushing_touchdowns"
            sorting={order}
            onToggle={handleSort}
          />
          <SortableColumnHeader
            label="Lng"
            field="longest_rush"
            sorting={order}
            onToggle={handleSort}
          />
          <span className="record__header-cell">1st</span>
          <span className="record__header-cell">1st%</span>
          <span className="record__header-cell">20+</span>
          <span className="record__header-cell">40+</span>
          <span className="record__header-cell">FUM</span>
        </li>
        {records.map((rec) => (
          <li className="record" key={rec.id}>
            <span className="record__cell">{rec.player_name}</span>
            <span className="record__cell">{rec.team}</span>
            <span className="record__cell">{rec.position}</span>
            <span className="record__cell">
              {rec.rushing_attempts_per_game}
            </span>
            <span className="record__cell">{rec.rushing_attempts}</span>
            <span className="record__cell">{rec.total_rushing_yards}</span>
            <span className="record__cell">
              {rec.avg_rushing_yards_per_attempt}
            </span>
            <span className="record__cell">{rec.rushing_yards_per_game}</span>
            <span className="record__cell">{rec.total_rushing_touchdowns}</span>
            <span className="record__cell">{rec.longest_rush}</span>
            <span className="record__cell">{rec.rushing_first_downs}</span>
            <span className="record__cell">
              {rec.rushing_first_down_percentage}
            </span>
            <span className="record__cell">
              {rec.rushing_20_yards_plus_each}
            </span>
            <span className="record__cell">
              {rec.rushing_40_yards_plus_each}
            </span>
            <span className="record__cell">{rec.rushing_fumbles}</span>
          </li>
        ))}
      </ul>
    </div>
  );
};

ReactDOM.render(<App />, document.getElementById("root"));
