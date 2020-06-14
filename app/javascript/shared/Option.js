import React from 'react';
import CorrectIcon from './CorrectIcon';

function CorrectOption() {
  return (
    <div className="input-group-append">
      <button type="button" className="btn btn-success" disabled>
        <CorrectIcon style={{ color: 'green' }} disabled />
      </button>
    </div>
  );
}

function Option({ option }) {
  return (
    <div
      className={`${
        option.is_correct ? 'border rounded border-success' : ''
      } input-group mt-1`}>
      <div className="input-group-prepend">
        <div className="input-group-text">
          <input
            type="radio"
            className="option-select"
            defaultChecked={option.is_correct}
            defaultValue={option.value}
            disabled
          />
        </div>
      </div>
      <input
        type="text"
        className="form-control option-value"
        name="option[value]"
        value={option.value}
        disabled
      />
      {option.is_correct ? <CorrectOption /> : ''}
    </div>
  );
}

export default Option;
