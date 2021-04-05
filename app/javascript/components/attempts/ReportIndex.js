import React, { Component } from "react";
import * as Routes from '../../utils/Routes';
import AttemptReport from "./AttemptReport";

export class ReportIndex extends Component {
  constructor(props) {
    super(props);
    this.state = {};
  }

  onSelect = (id) => {
    window.location.href = Routes.report_path(id.target.value)
  }

  render() {
    const { quizzes } = this.props;
    console.log(quizzes);

    return (
      <div>
        <div className="container mt-3">
          <div className="row mb-5">
            <h1 className="mr-5 col align-self-center">
              Select your quiz to see the report
            </h1>
            <select
              className="form-select form-select-lg mb-3 m-2"
              aria-label=".form-select-lg example"
              defaultValue="Click this !"
              onChange={this.onSelect}
            >
              {quizzes
                ? quizzes.map((quiz, id) => (
                     <option key={quiz.id} value={quiz.id}>{quiz.name}</option>                   
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
