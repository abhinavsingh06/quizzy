import React from 'react';
import AttemptQuestion from './AttemptQuestion';

function AttemptResult({ questions, attempt }) {
  console.log("helo")
  return (
    <div className="container">
      <div className="row p-4 justify-content-center">
        <div className="p-4 card col-9 border bg-dark text-white text-center">
          <h3 className="display-5">
            Thank you for taking the quiz, here are your submissions.
          </h3>
        </div>
      </div>
      <div className="row justify-content-center">
        <div className="pt-4 col-8">
          {questions
            ? questions.map((question, idx) => (
                <AttemptQuestion
                  key={idx}
                  number={idx + 1}
                  question={question}
                  submitted={attempt.submitted}
                  selectedAnswer={attempt.attempt_answers[idx].answer}
                />
              ))
            : ''}
        </div>
      </div>
    </div>
  );
}

export default AttemptResult;
