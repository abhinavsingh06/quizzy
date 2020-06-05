require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.new(email: "sam@example.com", password: "welcome")
  end

  # test "should get new" do
  #   get new_session_url

  #   assert_equal "new", @controller.action_name
  #   assert_response :success
  # end

  # test "should redirect new if logged in" do
  #   log_in_as(@user)
  #   get new_session_url

  #   assert_equal "new", @controller.action_name
  #   assert_redirected_to quizzes_url
  # end

  test "should redirect create on successful login" do
    log_in_as(@user)

    assert_equal "create", @controller.action_name
    # assert_not_nil session[:user_id]
    assert_select "[class=?]", "alert-success", count: 0
    assert_redirected_to quizzes_url
  end

  # test "should redirect create on failed login" do
  #   @user.email = "example@example.com"
  #   log_in_as(@user)

  #   assert_equal "create", @controller.action_name
  #   assert_equal "Incorrect credentials, try again.", flash[:danger]
  #   assert_redirected_to new_session_url
  # end

  # test "should redirect destroy when not logged in" do
  #   delete logout_url

  #   assert_equal "destroy", @controller.action_name
  #   assert_redirected_to login_url
  # end

  # test "should redirect destroy on logout" do
  #   log_in_as(@user)

  #   delete logout_url

  #   assert_equal "destroy", @controller.action_name
  #   assert_nil session[:user_id]
  #   assert_equal "Logged out!", flash[:warning]
  #   assert_redirected_to login_url
  # end
end
