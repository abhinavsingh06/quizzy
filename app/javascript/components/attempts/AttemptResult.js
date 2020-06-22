import React from 'react';
import AttemptQuestion from './AttemptQuestion';

function AttemptResult({ questions, attempt }) {
  return (
    <div className="container">
      <div className="row p-4 justify-content-center">
        <div className="p-4 card col-9 border bg-dark text-white text-center">
          <h3 className="display-5">
            Thank you for taking the quiz, here are your results.
          </h3>
          <hr className="my-4" />
          <p className="lead">
            You have submitted{' '}
            <strong>
              <span className="text-success">
                {attempt.correct_answers_count}
              </span>
            </strong>{' '}
            correct answers and{' '}
            <strong>
              <span className="text-danger">
                {attempt.incorrect_answers_count}
              </span>
            </strong>{' '}
            incorrect answers
          </p>
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
