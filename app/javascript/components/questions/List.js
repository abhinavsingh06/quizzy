import React from 'react';
import Question from './Question';

function List({ quiz, questions }) {
  return (
    <>
      {questions.map((question, idx) => (
        <div className="card m-2" key={idx}>
          <div className="card-body">
            <Question idx={idx} quiz={quiz} question={question} />
          </div>
        </div>
      ))}
    </>
  );
}

export default List;
