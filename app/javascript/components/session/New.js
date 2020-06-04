import React from 'react';
import { fetchApi } from '../../utils/API';
import * as Routes from '../../utils/Routes';

class New extends React.Component {
  constructor(props) {
    super(props);
    this.state = { user: { email: '', password: '' } };
  }

  handleChange = ({ target: { name, value } }) => {
    this.setState({ user: { ...this.state.user, [name]: value } });
  };

  handleSubmit = event => {
    event.preventDefault();
    fetchApi({
      url: Routes.login_path(),
      method: 'POST',
      body: {
        login: this.state.user,
      },
      onError: response => {
        console.log(response);
      },
      onSuccess: response => {
        console.log(response);
      },
      successCallBack: () => {
        window.location.href = Routes.quizzes_path();
      },
    });
  };

  render() {
    return (
      <>
        <div className="container">
          <form onSubmit={this.handleSubmit}>
            <div className="form-group">
              <label htmlFor="exampleInputEmail1">Email address</label>
              <input
                type="email"
                className="form-control"
                id="exampleInputEmail1"
                aria-describedby="emailHelp"
                name="email"
                value={this.state.email}
                onChange={this.handleChange}></input>
              <small id="emailHelp" className="form-text text-muted">
                We'll never share your email with anyone else.
              </small>
            </div>
            <div className="form-group">
              <label htmlFor="exampleInputPassword1">Password</label>
              <input
                type="password"
                className="form-control"
                id="exampleInputPassword1"
                name="password"
                value={this.state.password}
                onChange={this.handleChange}></input>
            </div>
            <button type="submit" className="btn btn-primary">
              Submit
            </button>
          </form>
        </div>
      </>
    );
  }
}

export default New;
