import React from 'react';

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
            Add questions
          </button>
        </div>
      </>
    );
  }
}

export default Show;
