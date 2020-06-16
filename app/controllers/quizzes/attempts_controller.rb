class Quizzes::AttemptsController < ApplicationController
  include AttemptsConcern

  skip_before_action :ensure_user_logged_in, :raise => false
  before_action :load_quiz

  def new
    render
  end
end
