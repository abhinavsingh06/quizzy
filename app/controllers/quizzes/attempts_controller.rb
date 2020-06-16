class Quizzes::AttemptsController < ApplicationController
  skip_before_action :ensure_user_logged_in
  before_action :load_quiz

  def new
    render
  end
end
