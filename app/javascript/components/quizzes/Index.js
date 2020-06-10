import React from 'react';
import * as Routes from '../../utils/Routes';
import List from './List';

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
            <button type="button" className="btn btn-primary btn-lg">
              <a href={Routes.new_quiz_path()} style={{ color: 'white' }}>
                Add new quiz
              </a>
            </button>
          </div>
          <div>
            <List quizzes={this.props} />
          </div>
        </div>
      </>
    );
  }
}

export default New;
