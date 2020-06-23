import React from 'react';
import { useTable } from 'react-table';

function AttemptReport({ quizzes }) {
  let reports = quizzes
    .map(rep => {
      return rep.attempts.map(attempt => attempt);
    })
    .flat();

  const data = reports
    ? reports.map(
        ({ quiz, user, correct_answers_count, incorrect_answers_count }) => ({
          quiz: quiz,
          user: user.first_name + ' ' + user.last_name,
          email: user.email,
          correct_answers_count,
          incorrect_answers_count,
        })
      )
    : [];

  const columns = [
    {
      Header: 'Quiz name',
      accessor: 'quiz',
    },
    {
      Header: 'User name',
      accessor: 'user',
    },
    {
      Header: 'Email',
      accessor: 'email',
    },
    {
      Header: 'Correct answers',
      accessor: 'correct_answers_count',
    },
    {
      Header: 'Incorrect answers',
      accessor: 'incorrect_answers_count',
    },
  ];

  const {
    getTableProps,
    getTableBodyProps,
    headerGroups,
    rows,
    prepareRow,
  } = useTable({ columns, data });

  return (
    <div className="container">
      <div className="card bg-dark text-white mt-2">
        <div className="card-body d-flex justify-content-between">
          <h3>Reports</h3>
          <button
            className="btn btn-sm btn-outline-primary"
            disabled={!reports}>
            Download
          </button>
        </div>
      </div>
      {reports ? (
        <div className="row mt-4 p-3">
          <table
            {...getTableProps()}
            className="table table-striped table-dark">
            <thead>
              {headerGroups.map(headerGroup => (
                <tr {...headerGroup.getHeaderGroupProps()}>
                  {headerGroup.headers.map(column => (
                    <th {...column.getHeaderProps()}>
                      {column.render('Header')}
                    </th>
                  ))}
                </tr>
              ))}
            </thead>
            <tbody {...getTableBodyProps()}>
              {rows.map(row => {
                prepareRow(row);
                return (
                  <tr {...row.getRowProps()}>
                    {row.cells.map(cell => {
                      return (
                        <td {...cell.getCellProps()}>{cell.render('Cell')}</td>
                      );
                    })}
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      ) : (
        <h2 className="p-4 text-muted text-center">Nothing to show</h2>
      )}
    </div>
  );
}

export default AttemptReport;
