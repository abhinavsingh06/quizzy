require 'test_helper'

class QuizTest < ActiveSupport::TestCase

  def setup
    @user = User.create!(first_name: "Example", last_name: "User" , email: "user@example.com", password: "welcome", role: 0)
    @quiz = Quiz.create!(name:"quiz", users_id: @user.id)
  end

  test "should be valid" do
    assert @quiz.valid?
  end

  test "name should be present" do
    @quiz.name = " " * 4
    assert @quiz.invalid?
    assert_equal ["can't be blank"], @quiz.errors[:name]
  end

  test "name should have a valid length" do
    @quiz.name = "a" * 3
    assert @quiz.invalid?
    assert_equal ["is too short (minimum is 4 characters)"], @quiz.errors[:name]
  end

  test "user id should be present" do
    @quiz = Quiz.create!(name: "test", users_id: @user.id)
    assert @quiz.valid?
  end
end
