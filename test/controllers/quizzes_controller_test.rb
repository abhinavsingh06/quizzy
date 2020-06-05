require 'test_helper'

class QuizzesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(first_name: "Sam", last_name: "Smith" , email: "sam@example.com", password: "welcome", role: 1)
    log_in_as(@user)
  end

  test "should redirect index when not logged in" do
    get quizzes_path

    assert_equal "index", @controller.action_name
    assert_redirected_to new_sessions_path
  end
end
