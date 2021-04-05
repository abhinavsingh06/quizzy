import React from 'react';
import { useTable } from 'react-table';
import { fetchApi } from '../../utils/API';
import * as Routes from '../../utils/Routes';

function ReportsTable(props) {
  
  const {quizzes} = props;
  console.log(Object.keys(quizzes))
  let reports = Object.keys(quizzes)
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
    <table {...getTableProps()} className="table table-striped table-dark">
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
        {rows.map(row => {
          prepareRow(row);
          return (
            <tr {...row.getRowProps()}>
              {row.cells.map(cell => {
                return <td {...cell.getCellProps()}>{cell.render('Cell')}</td>;
              })}
            </tr>
          );
        })}
      </tbody>
    </table>
  );
}

class AttemptReport extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      loading: false,
      csvData: null,
      job_id: null,
    };
  }


  render() {
    const { quiz, quizzes } = this.props;
    console.log(this.props)

    return (
      <div className="container">
        <div className="card bg-dark text-white">
          <div className="card-body d-flex justify-content-between">
            <h3>Reports</h3>
            <button
              className="btn btn-sm btn-outline-primary"
              data-toggle="modal"
              onClick={this.handleReports}
              disabled={this.state.loading}>
              {this.state.loading ? (
                <span
                  className="spinner-border spinner-border-sm"
                  role="status"
                  aria-hidden="true"></span>
              ) : (
                ''
              )}
              {this.state.loading ? ' Generating report' : 'Download'}
            </button>
          </div>
        </div>
        <div className="row mt-4 p-3">
          {quiz ? (
            <ReportsTable quizzes={quiz} />
          ) : (
            <h2 className="text-muted text-center">Noting to show here...</h2>
          )}
        </div>
      </div>
    );
  }
}

export default AttemptReport;
