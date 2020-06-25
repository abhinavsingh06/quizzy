class CreateReportService < ApplicationService
  HEADER_ROW = ["Quiz name", "User name", "Email", "Correct answers", "Incorrect answers"]

  def initialize(user_id, job_id)
    @user_id = user_id
    @job_id = job_id
  end
  
  def call
    current_user = User.find(@user_id)
    quizzes = current_user.quizzes.published.eager_load(submitted_attempts: :user)
    file_name = Time.now.strftime("%Y-%m-%d_%H-%M-%S") + "_report.csv"
    file_path = "#{Rails.root}/public/#{file_name}"
  end
end
