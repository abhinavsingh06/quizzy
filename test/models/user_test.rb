require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(first_name: "Example", last_name: "User" , email: "user@example.com", password: "welcome", role: 0)
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "first_name should be present" do
    @user.first_name = " "
    assert @user.invalid?
  end

  test "last_name should be present" do
    @user.last_name = " "
    assert @user.invalid?
  end

  test "email should be present" do
    @user.email = " "
    assert @user.invalid?
  end

  test "password should be present" do
    @user.password = "    "
    assert @user.invalid?
  end

  test "first_name should not exceed max length" do
    @user.first_name = "x" * 51
    assert @user.invalid?
  end

  test "last_name should not exceed max length" do
    @user.last_name = "y" * 51
    assert @user.invalid?
  end

  test "email should not exceed max length" do
    @user.email = "z" * 244 + "@example.com"
    assert @user.invalid?
  end

  test "password should have a minimum length" do
    @user.password = "z" * 5
    assert @user.valid?
  end

  test "password should not exceed max length" do
    @user.password = "z" * 9
    assert @user.invalid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@example.COM A_US-ER@example.com.org first.last@example.jp alice+bob@example.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    valid_addresses = %w[user@example,com user_at_example.org user.name@example. example@user_example.com example@xyz+xyz.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.invalid?, "#{valid_address.inspect} should be invalid"
    end
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert duplicate_user.invalid?
  end

  test "email address should be saved as lowercase" do
    test_email = "XyZ@ExamPLe.CoM"
    @user.email = test_email
    @user.save
    assert_equal test_email.downcase, @user.email
  end

  test "user should have a valid role" do
    invalid_role = "invalid_role"
    error = assert_raise ArgumentError do
      @user.role = invalid_role
    end
    assert_equal "'#{invalid_role}' is not a valid role", error.message
  end
end
