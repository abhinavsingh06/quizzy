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
          {window.location.pathname === '/sessions/new' ? (
            <a
              className="navbar-brand mr-5 text-primary"
              href={Routes.new_session_path()}>
              Login
            </a>
          ) : (
            ''
          )}
        </nav>
      </div>
    );
  }
}

export default Navbarin;
