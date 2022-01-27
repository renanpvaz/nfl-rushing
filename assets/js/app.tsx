import "../css/app.css";

import React, { useEffect, useState } from "react";
import ReactDOM from "react-dom";

const App: React.FC = () => {
  const [records, setRecords] = useState([]);

  useEffect(() => {
    fetch("http://localhost:4000/api/records")
      .then((res) => res.json())
      .then((res) => setRecords(res.data));
  }, []);

  return (
    <div className="content">
      <h1 className="heading">🏈 NFL Rushing</h1>
      <ul className="records">
        <li className="record record--header">
          <span className="record__header-cell">Name</span>
          <span className="record__header-cell">Team</span>
          <span className="record__header-cell">Pos</span>
          <span className="record__header-cell">Att/G</span>
          <span className="record__header-cell">Att</span>
          <span className="record__header-cell">Yds</span>
          <span className="record__header-cell">Avg</span>
          <span className="record__header-cell">Yds/G</span>
          <span className="record__header-cell">TD</span>
          <span className="record__header-cell">Lng</span>
          <span className="record__header-cell">1st</span>
          <span className="record__header-cell">1st%</span>
          <span className="record__header-cell">20+</span>
          <span className="record__header-cell">40+</span>
          <span className="record__header-cell">FUM</span>
        </li>
        {records.map((rec) => (
          <li className="record">
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
