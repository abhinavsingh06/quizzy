import React from 'react';
import * as Routes from '../../utils/Routes';
import { fetchApi } from '../../utils/API';
import Option from '../../shared/Option';

function Question({ idx, quiz, question }) {
  const { options } = question.question_multiple_choice;

  const handleDelete = event => {
    fetchApi({
      url: Routes.delete_quiz_question_path(quiz.id, question.id),
      method: 'DELETE',
      onError: response => {
        console.log(response);
      },
      onSuccess: response => {
        console.log(response);
      },
      successCallBack: () => {
        window.location.href = Routes.show_quiz_path(quiz.id);
      },
    });
  };

  return (
    <div className="shadow-sm border rounded bg-light p-2 text-white bg-dark">
      <main className="mt-2 pb-2">
        <p className="m-0 text-monospace">
          Q{idx + 1} {question.description}
        </p>
        {options.map((option, id) => (
          <Option option={option} key={id} />
        ))}
      </main>
      <footer>
        <div className="justify-content-end">
          <a href={Routes.edit_quiz_question_path(quiz.id, question.id)}>
            Edit
          </a>
          <a onClick={() => handleDelete()} style={{ cursor: 'pointer' }}>
            Delete
          </a>
        </div>
      </footer>
    </div>
  );
}

export default Question;
