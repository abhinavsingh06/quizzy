import React from 'react';
import * as Routes from '../../utils/Routes';

class Navbarin extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <nav className="navbar navbar-dark bg-primary">
          <a className="navbar-brand">Quizzy</a>
          <a className="navbar-brand" href={Routes.new_session_path()}>
            Login
          </a>
        </nav>
      </div>
    );
  }
}

export default Navbarin;
