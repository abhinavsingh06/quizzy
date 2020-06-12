import React from 'react';

function OptionInput({
  option,
  removeOption,
  handleChange,
  oldValue,
  isCorrect,
}) {
  return (
    <div className="input-group pt-1">
      <div className="input-group-prepend">
        <div className="input-group-text">
          <input
            type="radio"
            name="is_correct"
            className="option-select"
            data-id={option - 1}
            onChange={handleChange}
            defaultChecked={isCorrect}
          />
        </div>
      </div>
      <input
        type="text"
        className="form-control option-value"
        name="value"
        data-id={option - 1}
        onChange={handleChange}
        defaultValue={oldValue}
      />
      {option > 2 ? (
        <div className="input-group-append">
          <button
            type="button"
            className="btn btn-danger close"
            aria-label="Close"
            onClick={removeOption}>
            <span
              className="rounded-1 text-white btn-danger input-group-text"
              aria-hidden="true">
              &times;
            </span>
          </button>
        </div>
      ) : (
        ''
      )}
    </div>
  );
}

export default OptionInput;
