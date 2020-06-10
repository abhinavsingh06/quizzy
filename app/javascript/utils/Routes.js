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

export function edit_quiz_path(id) {
  return `/quizzes/${id}/edit`;
}

export function update_quiz_path(id) {
  return `/quizzes/${id}`;
}
