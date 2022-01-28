import "../css/app.css";

import React, { useEffect, useState } from "react";
import ReactDOM from "react-dom";

const SortableColumnHeader = ({ field, label, onToggle, sorting }) => (
  <button
    className="record__header-cell clickable"
    onClick={() => {
      onToggle([field, sorting[1] === "asc" ? "desc" : "asc"]);
    }}
  >
    {field === sorting[0] ? (sorting[1] === "asc" ? "↑" : "↓") : ""} {label}
  </button>
);

const App: React.FC = () => {
  const [records, setRecords] = useState([]);
  const [order, setOrder] = useState(["total_rushing_yards", "desc"]);

  useEffect(() => {
    fetch(`http://localhost:4000/api/records?sort=${order[0]}:${order[1]}`)
      .then((res) => res.json())
      .then((res) => setRecords(res.data));
  }, [order]);

  return (
    <div className="content">
      <header className="heading">
        <h1>🏈 NFL Rushing</h1>
        <div>
          <button className="button clickable">📄 export</button>
          <input className="search" type="search" placeholder="Player search" />
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
            onToggle={setOrder}
          />
          <span className="record__header-cell">Avg</span>
          <span className="record__header-cell">Yds/G</span>
          <SortableColumnHeader
            label="TD"
            field="total_rushing_touchdowns"
            sorting={order}
            onToggle={setOrder}
          />
          <SortableColumnHeader
            label="Lng"
            field="longest_rush"
            sorting={order}
            onToggle={setOrder}
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
