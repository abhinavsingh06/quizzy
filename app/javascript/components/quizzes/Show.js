import React from 'react';
import * as Routes from '../../utils/Routes';

class Show extends React.Component {
  constructor(props) {
    super(props);
  }
  render() {
    return (
      <>
        <div className="d-flex justify-content-between mt-3">
          <h2>{this.props.quiz.name}</h2>
          <button type="button" className="btn btn-primary">
            <a
              href={Routes.new_quiz_question_path(this.props.quiz.id)}
              style={{ color: 'white' }}>
              Add questions
            </a>
          </button>
        </div>
      </>
    );
  }
}

export default Show;
