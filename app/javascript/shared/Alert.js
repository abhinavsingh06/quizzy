import React from 'react';

function Alert({ type, messages }) {
  return (
    <React.Fragment>
      <div className={`alert alert-${type}`}>
        {messages.map(message => (
          <li key={message}>{message}</li>
        ))}
      </div>
    </React.Fragment>
  );
}

export default Alert;
