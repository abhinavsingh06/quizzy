require 'test_helper'

class JobTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(first_name: "Example", last_name: "User" , email: "user@example.com", password: "welcome", role: 1)
    @job = @user.jobs.build(job_id: "jid", filename: "report.csv")
  end

  test "should belong to a user" do
    @job.user = nil
    assert @job.invalid?
    assert_equal ["must exist"], @job.errors[:user]
  end

  test "should have a valid file name" do
    @job.filename = " "
    assert @job.invalid?
    assert_equal ["can't be blank"], @job.errors[:filename]
  end

  test "should have a valid job id" do
    @job.job_id = nil
    assert @job.invalid?
    assert_equal ["can't be blank"], @job.errors[:job_id]
  end
end
