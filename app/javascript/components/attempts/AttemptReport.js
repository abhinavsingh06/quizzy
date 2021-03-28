import React from 'react';
import { useTable } from 'react-table';
import { fetchApi } from '../../utils/API';
import * as Routes from '../../utils/Routes';

function ReportsTable(props) {
  
  const {quizzes} = props;
  console.log(props);
  
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

function ReportModal({ csvData }) {
  return (
    <div
      className="modal fade"
      id="report-modal"
      tabIndex="-1"
      role="dialog"
      aria-labelledby="exampleModalScrollableTitle"
      aria-hidden="true">
      <div className="modal-dialog modal-dialog-centered" role="document">
        <div className="modal-content">
          <div className="modal-header">
            <h5 className="modal-title" id="exampleModalScrollableTitle">
              Reports
            </h5>
            <button
              type="button"
              className="close"
              data-dismiss="modal"
              aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div className="modal-body">Your report is ready.</div>
          <div className="modal-footer">
            <button
              type="button"
              className="btn-sm btn-secondary"
              data-dismiss="modal"
              onClick={() => {
                window.location.reload(true);
              }}>
              Cancel
            </button>
            <a
              className="btn-sm btn-primary"
              href={`data:text/csv;charset=utf-8,${encodeURI(csvData)}`}
              target="_blank"
              download="reports.csv">
              Download
            </a>
          </div>
        </div>
      </div>
    </div>
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

  poll = async ({ fn, interval, maxAttempts }) => {
    let attempts = 0;
    const execPoll = async (resolve, reject) => {
      let validate = false;
      const result = await fn();
      attempts++;

      try {
        validate = !(await result.clone().json()).processing;
      } catch (err) {
        validate = true;
        return resolve(result);
      }

      if (maxAttempts && attempts == maxAttempts) {
        return reject(new Error('Exceeded max attempts'));
      } else {
        setTimeout(execPoll, interval, resolve, reject);
      }
    };

    return new Promise(execPoll);
  };

  handleReports = async () => {
    await fetchApi({
      url: Routes.reports_path(),
      method: 'POST',
      onError: response => {
        console.log(response);
      },
      onSuccess: response => {
        console.log(response);
      },
      successCallBack: response => {
        this.setState({ loading: true, job_id: response.job_id });
      },
    });

    const pollForCsv = await this.poll({
      fn: this.fetchReport,
      interval: 2000,
      maxAttempts: 5,
    });

    if (!this.state.csvData) {
      let csv = await pollForCsv.text();
      this.setState({ loading: false, csvData: csv }, () => {
        $('#report-modal').modal('toggle');
      });
    }
  };

  fetchReport = async () => {
    try {
      const { job_id } = this.state;
      let url = `${Routes.reports_path()}.csv${job_id ? `?jid=${job_id}` : ''}`;
      let res = await fetch(url, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          Accept: 'application/csv',
          'X-CSRF-TOKEN': document.querySelector('[name="csrf-token"]').content,
        },
      });

      return res;
    } catch (err) {
      console.error(err);
    }
  };

  render() {
    const { quizzes } = this.props;
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
          {quizzes ? (
            <ReportsTable quizzes={quizzes} />
          ) : (
            <h2 className="text-muted text-center">Noting to show here...</h2>
          )}
        </div>
        <ReportModal csvData={this.state.csvData} />
      </div>
    );
  }
}

export default AttemptReport;
