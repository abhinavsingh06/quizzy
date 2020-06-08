import React from 'react';
import * as Routes from '../../utils/Routes';

class New extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      quiz: { name: '' },
    };
  }

  render() {
    return (
      <>
        <div>
          <div className="w-100 p-3 d-flex justify-content-between">
            <h1>List of quizzes</h1>
            <button type="button" class="btn btn-primary btn-lg">
              <a href={Routes.new_quiz_path()} style={{ color: 'white' }}>
                Add new quiz
              </a>
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
