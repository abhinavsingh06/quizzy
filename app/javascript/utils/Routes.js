export function new_session_path() {
  return '/sessions/new';
}

export function login_path() {
  return '/sessions';
}

export function logout_path() {
  return '/sessions';
}

export function quizzes_path() {
  return '/quizzes';
}

export function new_quiz_path() {
  return '/quizzes/new';
}

export function add_quiz_path() {
  return '/quizzes';
}

export function show_quiz_path(id) {
  return `/quizzes/${id}`;
}

export function edit_quiz_path(id) {
  return `/quizzes/${id}/edit`;
}

export function update_quiz_path(id) {
  return `/quizzes/${id}`;
}

export function delete_quiz_path(id) {
  return `/quizzes/${id}`;
}

export function new_quiz_question_path(id) {
  return `${id}/questions/new`;
}

export function quiz_question_path(id) {
  return `/quizzes/${id}/questions`;
}

export function edit_quiz_question_path(quiz_id, question_id) {
  return `/quizzes/${quiz_id}/questions/${question_id}/edit`;
}

export function update_quiz_question_path(quiz_id, question_id) {
  return `/quizzes/${quiz_id}/questions/${question_id}`;
}
