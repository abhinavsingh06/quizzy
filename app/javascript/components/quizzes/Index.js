import React from 'react';

class New extends React.Component {
  render() {
    return (
      <>
        <div>
          <div className="w-100 p-3 d-flex justify-content-between">
            <h1>List of quizzes</h1>
            <button type="button" class="btn btn-primary btn-lg">
              Add new quiz
            </button>
          </div>
          <table class="table table-dark">
            <thead>
              <tr>
                <th scope="col" colspan="3">
                  Quiz name
                </th>
                <th scope="col">Edit</th>
                <th scope="col">Delete</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td colspan="3">Mark</td>
                <td>
                  <button type="button" class="btn btn-warning">
                    Edit
                  </button>
                </td>
                <td>
                  <button type="button" class="btn btn-danger">
                    Delete
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </>
    );
  }
}

export default New;
