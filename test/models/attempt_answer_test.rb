require 'test_helper'

class AttemptAnswerTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(first_name: "Example", last_name: "User" , email: "user@example.com", password: "welcome", role: 1)
    @quiz = @user.quizzes.build(name: "quiz")
    @quiz.save
    @question = @quiz.questions.build(description: "question",
      question_multiple_choice_attributes: {
        options: [{ is_correct: false, value: "false" }, { is_correct: true, value: "true" }]
      }
    )
    @question.save
    @participant = User.create!(first_name: "Dummy", last_name: "User" , email: "dummy@example.com", password: "password", role: 0)
    @attempt = @participant.attempts.build(quiz_id: @quiz.id)
    @attempt_answers = @attempt.attempt_answers.build(answer: "false",
      question_id: @question.id, attempt_id: @attempt.id)  
  end

  test "should be valid" do
    assert @attempt_answers.valid?
  end

  test "answer should be present" do
    @attempt_answers.answer = ""
    assert @attempt_answers.invalid?
    assert_equal ["can't be blank"], @attempt_answers.errors[:answer]
  end

  test "question id should be present" do
    @attempt_answers.question_id = nil
    assert @attempt_answers.invalid?
    assert_equal ["must exist"], @attempt_answers.errors[:question]
  end

  test "attempt id should be present" do
    @attempt_answers = AttemptAnswer.new(answer: "true", question_id: @question.id)
    assert @attempt_answers.invalid?
    assert_equal ["must exist"], @attempt_answers.errors[:attempt]
  end
end
