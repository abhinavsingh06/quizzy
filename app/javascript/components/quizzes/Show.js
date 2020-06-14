import React from 'react';
import * as Routes from '../../utils/Routes';
import List from '../questions/List';

class Show extends React.Component {
  constructor(props) {
    super(props);
  }
  render() {
    return (
      <>
        <div className="card text-white bg-dark">
          <div className="card-body">
            <div className="d-flex justify-content-between">
              <h2>{this.props.quiz.name}</h2>
              <div>
                {this.props.questions.length > 0 ? (
                  <button type="button" className="btn btn-primary mr-1">
                    <a style={{ color: 'white' }}>Publish</a>
                  </button>
                ) : (
                  ''
                )}
                <button type="button" className="btn btn-primary">
                  <a
                    href={Routes.new_quiz_question_path(this.props.quiz.id)}
                    style={{ color: 'white' }}>
                    Add questions
                  </a>
                </button>
              </div>
            </div>
          </div>
        </div>
        <List questions={this.props.questions} quiz={this.props.quiz} />
      </>
    );
  }
}

export default Show;
