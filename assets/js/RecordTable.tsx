import React from 'react'
import { RushingRecord, OrderState, SortableField } from './records'

type SortableColumnHeaderProps = {
  field: SortableField
  label: string
  onToggle: (f: SortableField) => void
  sorting: OrderState
}

type RecordTableHeaderProps = {
  order: OrderState
  onSort: (newOrder: OrderState) => void
}

type RecordTableProps = {
  data: RushingRecord[]
} & RecordTableHeaderProps

const omit = <T, K extends keyof T>(key: K, obj: T): Omit<T, K> => {
  const { [key]: _, ...rest } = obj
  return rest
}

const SortableColumnHeader: React.FC<SortableColumnHeaderProps> = ({
  field,
  label,
  onToggle,
  sorting,
}) => (
  <button
    className="record__header-cell clickable"
    onClick={() => onToggle(field)}
  >
    {field in sorting ? (sorting[field] === 'asc' ? '↑' : '↓') : '-'} {label}
  </button>
)

const RecordTableHeader: React.FC<RecordTableHeaderProps> = ({
  order,
  onSort,
}) => {
  const handleSort = (field: SortableField) => {
    const value = order[field]
    const newOrder =
      value === 'asc'
        ? omit(field, order)
        : {
            ...order,
            [field]: !value ? 'desc' : 'asc',
          }

    onSort(newOrder)
  }

  return (
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
      <span className="record__header-cell">FUM</span>{' '}
    </li>
  )
}

const RecordTable: React.FC<RecordTableProps> = ({ data, order, onSort }) => {
  return (
    <ul className="records">
      <RecordTableHeader order={order} onSort={onSort} />
      {data.map((rec) => (
        <li className="record" key={rec.id}>
          <span className="record__cell">{rec.player_name}</span>
          <span className="record__cell">{rec.team}</span>
          <span className="record__cell">{rec.position}</span>
          <span className="record__cell">{rec.rushing_attempts_per_game}</span>
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
          <span className="record__cell">{rec.rushing_20_yards_plus_each}</span>
          <span className="record__cell">{rec.rushing_40_yards_plus_each}</span>
          <span className="record__cell">{rec.rushing_fumbles}</span>
        </li>
      ))}
    </ul>
  )
}
export { RecordTable }
