require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(first_name: "Example", last_name: "User" , email: "user@example.com", password: "welcome", role: 1)
    @quiz = @user.quizzes.build(name: "quiz")
    @quiz.save
    @question = @quiz.questions.build(description: "question_sample",
      question_multiple_choice_attributes: {options: [{ is_correct: false, value: "false" }, { is_correct: true, value: "true" }]})
    @question.save
  end

  test "should be valid" do
    assert @question.valid?
  end

  test "should have a valid description" do
    @question.description = " " * 6
    assert @question.invalid?
    assert_equal ["can't be blank"], @question.errors[:description]
  end

  test "quiz id should be present" do
    @question = Question.create({ description: "question",
        question_multiple_choice_attributes: {options: [{ is_correct: false, value: "false" }, { is_correct: true, value: "true" }]}})
    assert @question.invalid?
    assert_equal ["must exist"], @question.errors[:quiz]
  end

  test "question should have options" do
    @question.question_multiple_choice.options = nil
    assert @question.invalid?
    assert_equal ["can't be blank"], @question.errors["question_multiple_choice.options"]
  end

  test "question should have a correct option" do
    @question.question_multiple_choice.options = [{ is_correct: false, value: "false" }, { is_correct: false, value: "true" }]
    assert @question.invalid?
    assert_equal ["should have a correct answer"], @question.errors["question_multiple_choice.option"]
  end

  test "option should have a valid length" do
    @question.question_multiple_choice.options = [{ is_correct: false, value: "" }, { is_correct: true, value: "true" }]
    assert @question.invalid?
    assert_equal ["should have a valid length"], @question.errors["question_multiple_choice.option"]
  end
end
