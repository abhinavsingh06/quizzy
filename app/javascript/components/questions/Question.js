import React, { Component } from 'react';

export class Question extends Component {
  constructor(props) {
    super(props);
  }
  render() {
    console.log(this.props);
    return (
      <div>
        <h1>hello</h1>
      </div>
    );
  }
}

export default Question;
