import React, { Component } from "react";
import AttemptReport from "./AttemptReport";

export class ReportIndex extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  render() {
    const { quizzes } = this.props;

    return (
      <div>
        <div className="container mt-3">
          <div className="row mb-5">
            <h1 className="mr-5 col align-self-center">
              Select your quiz to see the report
            </h1>
            <select
              className="form-select form-select-lg mb-3"
              aria-label=".form-select-lg example"
            >
              {quizzes
                ? quizzes.map((quiz, id) => (
                    <>
                      {/* <option selected>Click this !</option> */}
                      <option value={id}>{quiz}</option>
                    </>
                  ))
                : ""}
            </select>
          </div>
          <div>
            <AttemptReport />
          </div>
        </div>
      </div>
    );
  }
}

export default ReportIndex;
