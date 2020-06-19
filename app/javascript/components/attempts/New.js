import React, { Component } from 'react';
import { fetchApi } from '../../utils/API';
import * as Routes from '../../utils/Routes';
import Alert from '../../shared/Alert';

export class New extends Component {
  constructor(props) {
    super(props);
    this.state = {
      attempt: {
        user: {
          first_name: '',
          last_name: '',
          email: '',
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

  handleChange = ({ target: { name, value } }) => {
    const { attempt } = this.state;
    this.setState({
      attempt: { user: { ...attempt.user, [name]: value } },
    });
  };

  handleSubmit = event => {
    event.preventDefault();
    fetchApi({
      url: Routes.attempt_path(this.props.quiz.slug),
      method: 'POST',
      body: {
        attempt: this.state.attempt,
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
        <div className="container w-50 mt-5">
          <div className="card text-white bg-dark">
            <div className="card-body mt-5 mb-5">
              <h1 className="card-text text-center">Welcome to Quizzy.</h1>
              <h6 className="card-text text-center">
                Please fill in the details to continue.
              </h6>
            </div>
          </div>
          <div className="d-flex justify-content-center">
            {this.state.alert.message && this.displayErrors()}
          </div>
          <form className="mt-5" onSubmit={this.handleSubmit}>
            <div className="row mb-3">
              <div className="col">
                <input
                  type="text"
                  className="form-control"
                  placeholder="First name"
                  name="first_name"
                  onChange={this.handleChange}
                />
              </div>
              <div className="col">
                <input
                  type="text"
                  className="form-control"
                  placeholder="Last name"
                  name="last_name"
                  onChange={this.handleChange}
                />
              </div>
            </div>
            <div className="form-group">
              <input
                type="email"
                placeholder="Email address"
                className="form-control"
                id="exampleInputEmail1"
                aria-describedby="emailHelp"
                name="email"
                onChange={this.handleChange}
              />
              <small id="emailHelp" className="form-text text-muted">
                We'll never share your email with anyone else.
              </small>
            </div>
            <button className="btn btn-primary text-center" type="submit">
              Next
            </button>
          </form>
        </div>
      </>
    );
  }
}

export default New;
