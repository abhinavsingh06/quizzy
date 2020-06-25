import React from 'react';
import * as Routes from '../../utils/Routes';

class Navbarin extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <nav className="navbar navbar-dark p-3 mb-2 bg-dark text-white">
          <a className="navbar-brand ml-5">Quizzy</a>
        </nav>
      </div>
    );
  }
}

export default Navbarin;
