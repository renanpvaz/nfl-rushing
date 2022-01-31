import "../css/app.css";

import React from "react";
import ReactDOM from "react-dom";
import { useRecords } from "./records";
import { RecordTable } from "./RecordTable";

const App: React.FC = () => {
  const [{ records, params, query }, setParams] = useRecords();
  return (
    <div className="content">
      <header className="heading">
        <h1>🏈 NFL Rushing</h1>
        <div>
          <a
            className="button"
            href={`http://localhost:4000/api/records/report?${query}`}
            download="rushing.csv"
          >
            📄 Export CSV
          </a>

          <input
            className="search"
            type="search"
            placeholder="Player search"
            value={params.search}
            onChange={(e) => setParams({ search: e.target.value, page: 1 })}
          />
        </div>
      </header>
      <RecordTable
        data={records}
        order={params.order}
        onSort={(newOrder) => setParams({ order: newOrder })}
      />
      <footer className="pagination">
        <button
          className="button button--secondary"
          onClick={() => setParams({ page: params.page - 1 })}
          disabled={params.page === 1}
        >
          {"<"}
        </button>
        <span className="pagination__page">{params.page}</span>
        <button
          className="button button--secondary"
          onClick={() => setParams({ page: params.page + 1 })}
          disabled={records.length < 20}
        >
          {">"}
        </button>
      </footer>
    </div>
  );
};

ReactDOM.render(<App />, document.getElementById("root"));
