import React from 'react';

function Alert({ type, messages }) {
  return (
    <>
      <div className={`alert alert-dismissible fade show alert-${type}`}>
        {messages.map(message => (
          <li key={message}>{message}</li>
        ))}
        <button
          type="button"
          className="close"
          data-dismiss="alert"
          aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
    </>
  );
}

export default Alert;
