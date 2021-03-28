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

function Option({
  number,
  option,
  question,
  handleAnswer,
  submitted,
  selectedAnswer,
}) {
  return (
    <div
      className={`${
        option.value && submitted ? 'border rounded border-success' : ''
      } input-group mt-1`}
      >
      <div className="input-group-prepend">
        <div className="input-group-text">
          <input
            type="radio"
            className="option-select"
            defaultChecked={
              question ? selectedAnswer == option.value : ""
            }
            defaultValue={option.value}
            name={question ? `${question - 1}-option` : ''}
            data-id={handleAnswer ? number : null}
            onClick={handleAnswer ? handleAnswer : null}
            disabled={submitted ? true : question ? false : true}
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
      {/* {question && !submitted ? '' : option.is_correct ? <CorrectOption /> : ''} */}
      {question && !submitted ? '' : option.is_correct ? "" : ''}
    </div>
  );
}

export default Option;
