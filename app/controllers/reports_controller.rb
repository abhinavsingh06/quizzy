class ReportsController < ApplicationController
  before_action :ensure_user_admin
  
  def show
    @quizzes = current_user.quizzes.published.eager_load(submitted_attempts: :user)
  end
end
