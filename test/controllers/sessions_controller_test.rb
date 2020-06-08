require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create!(first_name: "Sam", last_name: "Smith" , email: "sam@example.com", password: "welcome", role: 1)
  end

  test "should get new" do
    get new_sessions_url

    assert_equal "new", @controller.action_name
    assert_response :success
  end

  test "should redirect new if logged in" do
    log_in_as(@user)
    get new_sessions_path

    assert_equal "new", @controller.action_name
    assert_redirected_to quizzes_path
  end

  test "should redirect create on successful login" do
    log_in_as(@user)

    assert_equal "create", @controller.action_name
    assert_not_nil session[:user_id]
    assert_equal 'Successfully logged in!', flash[:success]
    assert_redirected_to quizzes_path
  end

  test "should redirect create on failed login" do
    @user.email = "example@example.com"
    log_in_as(@user)

    assert_equal "create", @controller.action_name
    assert_equal "Incorrect credentials, try again.", flash[:danger]
    assert_redirected_to new_sessions_path
  end

  test "should redirect destroy when not logged in" do
    delete sessions_path

    assert_equal "destroy", @controller.action_name
    assert_redirected_to root_path
  end

  test "should redirect destroy on logout" do
    log_in_as(@user)

    delete sessions_path

    assert_equal "destroy", @controller.action_name
    assert_nil session[:user_id]
    assert_equal "Successfully logged out!", flash[:success]
    assert_redirected_to root_path
  end
end
