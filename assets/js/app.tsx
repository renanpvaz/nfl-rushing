import "../css/app.css";

import React from "react";
import ReactDOM from "react-dom";
import { useRecords, isValidPageSize } from "./records";
import { RecordTable } from "./RecordTable";

const App: React.FC = () => {
  const [{ records, totalPages, params, query }, setParams] = useRecords();

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
            className="input"
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
        <select
          className="button"
          onChange={({ target: { value } }) => {
            if (isValidPageSize(value)) setParams({ page: 1, pageSize: value });
          }}
        >
          <option value="25">Show 25</option>
          <option value="50">Show 50</option>
          <option value="100">Show 100</option>
        </select>
        <button
          className="pagination__button clickable"
          onClick={() => setParams({ page: params.page - 1 })}
          disabled={params.page === 1}
        >
          {"<"}
        </button>
        <span className="pagination__page">
          {params.page} / {totalPages}
        </span>
        <button
          className="pagination__button clickable"
          onClick={() => setParams({ page: params.page + 1 })}
          disabled={params.page === totalPages}
        >
          {">"}
        </button>
      </footer>
    </div>
  );
};

ReactDOM.render(<App />, document.getElementById("root"));
