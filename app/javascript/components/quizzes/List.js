import React from 'react';
import * as Routes from '../../utils/Routes';
import { useTable } from 'react-table';

function Table({ columns, data }) {
  const {
    getTableProps,
    getTableBodyProps,
    headerGroups,
    rows,
    prepareRow,
  } = useTable({
    columns,
    data,
  });

  return (
    <table {...getTableProps()} className="table table-dark">
      <thead>
        {headerGroups.map(headerGroup => (
          <tr {...headerGroup.getHeaderGroupProps()}>
            {headerGroup.headers.map(column => (
              <th {...column.getHeaderProps()}>{column.render('Header')}</th>
            ))}
          </tr>
        ))}
      </thead>
      <tbody {...getTableBodyProps()}>
        {rows.map((row, i) => {
          prepareRow(row);
          return (
            <tr {...row.getRowProps()}>
              {row.cells.map(cell => {
                return <td {...cell.getCellProps()}>{cell.render('Cell')}</td>;
              })}
              <td>
                <button type="button" className="btn btn-warning">
                  <a href={Routes.edit_quiz_path(row.original.id)}>Edit</a>
                </button>
              </td>
              <td>
                <button type="button" className="btn btn-danger">
                  <a href={Routes.edit_quiz_path()}>Delete</a>
                </button>
              </td>
            </tr>
          );
        })}
      </tbody>
    </table>
  );
}

export default function List({ quizzes }) {
  const data = quizzes;
  const columns = React.useMemo(
    () => [
      {
        Header: 'Quiz Name',
        accessor: 'name',
      },
    ],
    []
  );

  return (
    <>
      <Table columns={columns} data={data.quizzes} />
    </>
  );
}
