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

    CSV.open(file_path, "wb") do |csv|
      csv << HEADER_ROW
      quizzes.each do |quiz|
        quiz.submitted_attempts.each do |attempt|
          csv << [quiz.name,
                "#{attempt.user.first_name} #{attempt.user.last_name}",
                attempt.user.email,
                attempt.correct_answers_count,
                attempt.incorrect_answers_count]
        end
      end
    end
    job = current_user.jobs.create(job_id: @job_id, filename: file_path, status: "done")
  end
end
