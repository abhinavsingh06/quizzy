json.quizzes @quizzes do |quiz|
  json.attempts quiz.submitted_attempts do |attempt|
    json.quiz quiz.name
    json.extract! attempt, :user, :correct_answers_count, :incorrect_answers_count
  end
end
