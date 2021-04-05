# json.quiz do
#   json.quiz @quiz.name
#   json.questions @quiz.questions do |question|
#     json.description question.description
#     json.id question.id
#   end

#   json.array!(@attempts) do |json, attempt|
#     json.set!(attempt.attempt_answers)
#   end
# end
json.quiz @question
json.quizzes @quizzes
