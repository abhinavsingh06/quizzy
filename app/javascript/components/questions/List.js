import React from 'react';
import PropTypes from 'prop-types';
import Question from './Question';

class List extends React.Component {
  constructor(props) {
    super(props);
  }
  render() {
    return (
      <>
        <div className="card">
          <div className="card-body">
            <Question questions={this.props} />
          </div>
        </div>
      </>
    );
  }
}

export default List;
