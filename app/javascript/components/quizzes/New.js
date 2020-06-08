import React from 'react';
import * as Routes from '../../utils/Routes';
import { fetchApi } from '../../utils/API';
import Alert from '../../shared/Alert';

class New extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      quiz: { name: '' },
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

  handleChange = ({ target: { name, value } }) => {
    this.setState({ quiz: { ...this.state.user, [name]: value } });
  };

  handleSubmit = event => {
    event.preventDefault();
    fetchApi({
      url: Routes.add_quiz_path(),
      method: 'POST',
      body: {
        quiz: this.state.quiz,
      },
      onError: this.updateAlert,
      onSuccess: this.updateAlert,
      successCallBack: () => {
        window.location.href = Routes.quizzes_path();
      },
    });
  };

  render() {
    return (
      <>
        <div className="container mt-5">
          {this.state.alert.message && this.displayErrors()}
          <h1 className="mb-5">Add new quiz</h1>
          <form
            className="needs-validation"
            noValidate
            onSubmit={this.handleSubmit}>
            <div className="form-row">
              <div className="col-md-6 mb-3">
                <label htmlFor="validationTooltip03">Quiz name</label>
                <input
                  type="text"
                  value={this.state.quiz.name}
                  name="name"
                  className="form-control"
                  id="validationTooltip03"
                  required
                  onChange={this.handleChange}></input>
                <div className="invalid-tooltip">
                  Please provide a valid name.
                </div>
              </div>
            </div>
            <button className="btn btn-primary" type="submit">
              Submit
            </button>
          </form>
        </div>
      </>
    );
  }
}

export default New;
