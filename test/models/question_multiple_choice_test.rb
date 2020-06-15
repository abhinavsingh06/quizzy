require 'test_helper'

class QuestionMultipleChoiceTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(first_name: "Example", last_name: "User" , email: "user@example.com", password: "welcome", role: 1)
    @quiz = @user.quizzes.build(name: "quiz")
    @quiz.save
    @question = @quiz.questions.create(description: "question")
    @options = @question.build_question_multiple_choice(options: [{ is_correct: false, value: "false" }, { is_correct: true, value: "true" }])
  end

  test "should be valid" do
    assert @options.valid?
  end

  test "question should have a correct answer" do
    @options = @question.build_question_multiple_choice(options:
      [{ is_correct: false, value: "false" },
      { is_correct: false, value: "true" }]
    )
    assert @options.invalid?
    assert_equal ["should have a correct answer"], @options.errors[:option]
  end

  test "options can't be blank" do
    @options = @question.build_question_multiple_choice(options:
      [{ is_correct: false, value: "false" },
      { is_correct: true, value: "" }]
    )
    assert @options.invalid?
    assert_equal ["should have a valid length"], @options.errors[:option]
  end
end
