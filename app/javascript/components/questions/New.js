import React from 'react';
import { fetchApi } from '../../utils/API';
import * as Routes from '../../utils/Routes';
import OptionInput from '../../shared/OptionInput';
import Alert from '../../shared/Alert';

class QuestionForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      optionCount: 4,
      question: {
        description: '',
        question_multiple_choice_attributes: {
          options: [],
        },
      },
      alert: {
        message: null,
        type: null,
      },
    };
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

  componentDidMount() {
    const { question } = this.props;
    const options = question ? question.question_multiple_choice.options : null;
    const optionCount = options ? options.length : 4;

    this.setState({
      optionCount: optionCount,
      question: {
        description: question ? question.description : '',
        question_multiple_choice_attributes: {
          options: new Array(optionCount).fill(0).map((_, idx) => ({
            // is_correct:
            //   options && options[idx] ? options[idx].is_correct : false,
            value: options && options[idx] ? options[idx].value : '',
          })),
        },
      },
    });
  }

  handleOption = ({ target: { name, value, dataset } }) => {
    let { options } = this.state.question.question_multiple_choice_attributes;

    this.setState({
      question: {
        ...this.state.question,
        question_multiple_choice_attributes: {
          options: options.map((option, idx) => {
            // if (name == 'is_correct') {
            //   return idx == dataset.id
            //     ? { ...option, is_correct: true }
            //     : { ...option, is_correct: false };
            // } else {
              return idx == dataset.id ? { ...option, value: value } : option;
            // }
          }),
        },
      },
    });
  };

  handleChange = ({ target: { name, value } }) => {
    this.setState({ question: { ...this.state.question, [name]: value } });
  };

  addOption = () => {
    let { optionCount, question } = this.state;
    let { options } = question.question_multiple_choice_attributes;

    this.setState({
      optionCount: ++optionCount,
      question: {
        ...question,
        question_multiple_choice_attributes: {
          // options: options.concat([{ is_correct: false, value: '' }]),
          options: options.concat([{ value: '' }]),
        },
      },
    });
  };

  removeOption = () => {
    let { optionCount, question } = this.state;
    let { options } = question.question_multiple_choice_attributes;

    this.setState({
      optionCount: --optionCount,
      question: {
        ...question,
        question_multiple_choice_attributes: {
          options: options.slice(0, optionCount),
        },
      },
    });
  };

  handleSubmit = event => {
    const { question } = this.props;
    event.preventDefault();
    fetchApi({
      url: question
        ? Routes.update_quiz_question_path(
            this.props.quiz.id,
            this.props.question.id
          )
        : Routes.quiz_question_path(this.props.quiz.id),
      method: question ? 'PUT' : 'POST',
      body: {
        question: { ...this.state.question },
      },
      onError: this.updateAlert,
      onSuccess: this.updateAlert,
      successCallBack: () => {
        window.location.href = Routes.show_quiz_path(this.props.quiz.id);
      },
    });
  };

  render() {
    const { question, quiz } = this.props;
    const { optionCount } = this.state;
    const options = question ? question.question_multiple_choice.options : null;

    return (
      <div className="container">
        <h2 className="p-2 text-center text-secondary">
          Add your question here.
        </h2>
        <div className="d-flex justify-content-center">
          {this.state.alert.message && this.displayErrors()}
        </div>
        <div className="card w-75 mt-3" style={{ margin: '0 auto' }}>
          <div className="card-body">
            <div className="column">
              <h2 className="p-3 card-header text-center border bg-dark text-white">
                {quiz.name}
              </h2>
              <form className="p-1 mt-4" onSubmit={this.handleSubmit}>
                <div className="form-group">
                  <h4 className="text-secondary">Question:</h4>
                  <textarea
                    type="text"
                    className="form-control"
                    id="description"
                    name="description"
                    onChange={this.handleChange}
                    defaultValue={question ? question.description : ''}
                    placeholder="Ask a question"
                  />
                </div>
                <h5 className="text-secondary">Options:</h5>
                {new Array(optionCount).fill(0).map((_, option) => (
                  <OptionInput
                    removeOption={this.removeOption}
                    option={1 + option}
                    handleChange={this.handleOption}
                    oldValue={
                      options && options[option] ? options[option].value : ''
                    }
                    // isCorrect={
                    //   options && options[option]
                    //     ? options[option].is_correct
                    //     : false
                    // }
                    key={`${quiz.id}-${option + 1}`}
                  />
                ))}
                {optionCount < 4 ? (
                  <div className="form-group mt-2">
                    <button
                      type="button"
                      className="btn btn-outline-primary btn-sm"
                      onClick={this.addOption}>
                      Add Option
                    </button>
                  </div>
                ) : (
                  ''
                )}
                <input
                  type="submit"
                  className="btn btn-primary mt-2"
                  value={question ? 'Update Question' : 'Add Question'}
                  onClick={this.handleSubmit}
                />
              </form>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default QuestionForm;
