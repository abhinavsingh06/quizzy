import React from 'react';
import Option from '../../shared/Option';

function AttemptQuestion({
  number,
  question,
  handleAnswer,
  submitted,
  selectedAnswer,
}) {
  const { options } = question.question_multiple_choice;

  return (
    <div className="mt-2 mb-4 d-flex justify-content-between">
      <div className="shadow-sm border rounded bg-light p-2 text-white bg-dark w-100">
        <div className="w-100 p-0 pb-4">
          <div className="d-flex justify-content-start">
            <h5 className="col-1 p-0">
              <span className="badge badge-secondary">Q {number}</span>
            </h5>
            <p>{question.description}</p>
          </div>
          <div>
            {options
              ? options.map((option, idx) => (
                  <Option
                    key={idx}
                    question={number}
                    number={idx}
                    option={option}
                    handleAnswer={handleAnswer}
                    submitted={submitted}
                    selectedAnswer={selectedAnswer}
                  />
                ))
              : ''}
          </div>
        </div>
      </div>
    </div>
  );
}

export default AttemptQuestion;
