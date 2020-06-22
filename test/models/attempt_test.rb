require 'test_helper'

class AttemptTest < ActiveSupport::TestCase
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
  end

  test "should be valid" do
    assert @attempt.valid?
  end

  test "quiz id should be present" do
    @attempt.quiz_id = nil
    assert @attempt.invalid?
    assert_equal ["must exist"], @attempt.errors[:quiz]
  end

  test "correct answers count should be present" do
    @attempt.correct_answers_count = " "
    assert @attempt.invalid?
    assert_equal ["can't be blank"], @attempt.errors.messages[:correct_answers_count]
  end
  
  test "incorrect answers count should be present" do
    @attempt.incorrect_answers_count = " "
    assert @attempt.invalid?
    assert_equal ["can't be blank"], @attempt.errors.messages[:incorrect_answers_count]
  end
end
