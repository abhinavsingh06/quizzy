import React from 'react';
import * as Routes from '../../utils/Routes';
import Option from '../../shared/Option';

function Question({ idx, quiz, question }) {
  const { options } = question.question_multiple_choice;
  return (
    <div className="shadow-sm border rounded bg-light p-2 text-white bg-dark">
      <main className="mt-2 pb-2">
        <p className="m-0 text-monospace">
          Q{idx + 1} {question.description}
        </p>
        {/* {options.map(option => (
          <Option option={option} />
        ))} */}
      </main>
      <footer>
        <div className="justify-content-end">
          <a href={Routes.edit_quiz_question_path(quiz.id, question.id)}>
            Edit
          </a>
          <a>Delete</a>
        </div>
      </footer>
    </div>
  );
}

export default Question;
