export function session_index() {
  return '/session/new';
}

export function login_path() {
  return '/session';
}

export function logout_path(id) {
  return `/session/${id}`;
}

export function quizzes_path() {
  return '/quizzes';
}
