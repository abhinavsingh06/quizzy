import React, { Component } from 'react';
import AttemptQuestion from './AttemptQuestion';
import { fetchApi } from '../../utils/API';
import * as Routes from '../../utils/Routes';
import Alert from '../../shared/Alert';

export class AttemptPage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      attempt_answers_attributes: [],
      alert: {
        message: null,
        type: null,
      },
    };
  }

  componentDidMount() {
    const { questions, attempt } = this.props;

    this.setState({
      attempt: {
        attempt_answers_attributes: questions.map(question => ({
          question_id: question.id,
          answer: '',
        })),
      },
    });
  }

  updateAlert = response => {
    this.setState({
      alert: {
        message: response.messages,
        type: response.type,
      },
    });
  };

  displayErrors = () => {
    const { message, type } = this.state.alert;
    return (
      <div className="row">
        <div className="mt-4">
          <Alert type={type} messages={message} />
        </div>
      </div>
    );
  };

  handleAnswer = ({ target: { name, value } }) => {
    const {
      attempt: { attempt_answers_attributes },
    } = this.state;
    let question = name.split('-')[0];

    this.setState({
      attempt: {
        attempt_answers_attributes: attempt_answers_attributes.map(
          (answer, idx) => {
            if (question == idx) {
              answer.answer = value;
            }
            return answer;
          }
        ),
      },
    });
  };

  handleSubmit = event => {
    const { quiz, attempt } = this.props;
    event.preventDefault();
    fetchApi({
      url: Routes.update_attempt_path(quiz.slug, attempt.id),
      method: 'PUT',
      body: {
        attempt: this.state.attempt,
      },
      onError: this.updateAlert,
      onSuccess: this.updateAlert,
      successCallBack: () => {
        window.location.href = Routes.show_attempt_path(quiz.slug, attempt.id);
      },
    });
  };

  render() {
    const { quiz, questions, participant, attempt } = this.props;
    return (
      <>
        <div className="container">
          <div className="row justify-content-md-center flex-column align-items-center">
            <div className="bg-dark text-white border card mt-2 mb-2 col-sm-8">
              <div className="card-body">
                <h3 className="text-center">
                  Welcome to {quiz.name}
                  {'!'}
                </h3>
              </div>
            </div>
            <div className="d-flex justify-content-center">
              {this.state.alert.message && this.displayErrors()}
            </div>
            <form className="col-sm-8 p-3" onSubmit={this.handleSubmit}>
              <div className="pt-4">
                {questions
                  ? questions.map((question, idx) => (
                      <AttemptQuestion
                        key={idx}
                        number={idx + 1}
                        question={question}
                        handleAnswer={this.handleAnswer}
                        submitted={attempt.submitted}
                      />
                    ))
                  : ''}
              </div>
              <button type="submit" className="float-right btn btn-primary">
                Submit
              </button>
            </form>
          </div>
        </div>
      </>
    );
  }
}

export default AttemptPage;
