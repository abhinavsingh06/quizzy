import React, { Component } from 'react';

export class New extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    console.log(this.props);
    return (
      <>
        <div className="container w-50 mt-5">
          <div class="card text-white bg-dark">
            <div class="card-body mt-5 mb-5">
              <h1 className="card-text text-center">Welcome to Quizzy.</h1>
              <h6 className="card-text text-center">
                Please fill in the details to continue.
              </h6>
            </div>
          </div>
          <form className="mt-5">
            <div className="row mb-3">
              <div className="col">
                <input
                  type="text"
                  class="form-control"
                  placeholder="First name"
                />
              </div>
              <div className="col">
                <input
                  type="text"
                  class="form-control"
                  placeholder="Last name"
                />
              </div>
            </div>
            <div class="form-group">
              <input
                type="email"
                placeholder="Email address"
                class="form-control"
                id="exampleInputEmail1"
                aria-describedby="emailHelp"
              />
              <small id="emailHelp" class="form-text text-muted">
                We'll never share your email with anyone else.
              </small>
            </div>
            <a href="#" class="btn btn-primary text-center">
              Next
            </a>
          </form>
        </div>
      </>
    );
  }
}

export default New;
