import React from 'react';
import * as Routes from '../../utils/Routes';
import { fetchApi } from '../../utils/API';
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

  const handleDelete = id => {
    let quizDelete = confirm('Are you sure you want to delete the task?');
    if (quizDelete) {
      fetchApi({
        url: Routes.delete_quiz_path(id),
        method: 'DELETE',
        onError: response => {
          console.log(response);
        },
        onSuccess: response => {
          console.log(response);
        },
        successCallBack: () => {
          window.location.replace(Routes.quizzes_path());
        },
      });
    }
  };
  console.log(data);
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
      {data.length ? (
        <tbody {...getTableBodyProps()}>
          {rows.map((row, i) => {
            prepareRow(row);
            return (
              <tr {...row.getRowProps()}>
                {row.cells.map(cell => {
                  return (
                    <td {...cell.getCellProps()}>
                      <a href={Routes.show_quiz_path(row.original.id)}>
                        {cell.render('Cell')}
                      </a>
                    </td>
                  );
                })}
                <td>
                  <button type="button" className="btn btn-warning">
                    <a href={Routes.edit_quiz_path(row.original.id)}>Edit</a>
                  </button>
                </td>
                <td>
                  <button
                    type="button"
                    className="btn btn-danger"
                    onClick={() => handleDelete(row.original.id)}>
                    Delete
                  </button>
                </td>
              </tr>
            );
          })}
        </tbody>
      ) : (
        <h4 className="text-center">No quiz is present at the moment!</h4>
      )}
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
