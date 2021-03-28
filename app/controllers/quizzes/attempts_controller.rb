class Quizzes::AttemptsController < ApplicationController
  include AttemptsConcern

  skip_before_action :ensure_user_logged_in, :raise => false
  before_action :load_quiz
  before_action :load_questions_with_options, only: [:show, :edit, :update]
  before_action :ensure_participant_logged_in, only: [:show, :edit, :update]
  before_action :ensure_quiz_not_attempted, only: [:edit, :update]

  def new
    render
  end

  def create
    response = AttemptCreator.call(participant_attributes, @quiz.id)
    unless response.success?
      response.errors.each do |message|
        flash.now[:danger] ||= message
      end
      return render status: :unprocessable_entity, json: { errors: flash }
    end
    session[:attempt_id] = response.attempt.id.to_s
    render status: :ok, json: { notice:"You can now attempt the quiz!", attempt_id: response.attempt.id }
  end

  def show
    @attempt = @attempt.as_json(include: :attempt_answers)
  end

  def edit
    render
  end

  def update
    if @attempt.update(attempt_attributes)
      render status: :ok, json: { notice: "Thank you for taking the quiz!" }
    else
      @attempt.errors.full_messages.each do |message|
        flash.now[:danger] ||= message
      end
      render status: :unprocessable_entity, json: { errors: @attempt.errors.full_messages }
    end
  end

  private

  def participant_params
    params.require(:attempt).permit(user: [:first_name, :last_name, :email])
  end

  def attempt_params
    params.require(:attempt).permit(attempt_answers_attributes: [:answer, :question_id])
  end

  def participant_attributes
    { email: participant_params[:user][:email],
      first_name: participant_params[:user][:first_name],
      last_name: participant_params[:user][:last_name],
      password: "password",
      password_confirmation: "password" }
  end

  def attempt_attributes
    result = QuestionsChecker.call(@questions, attempt_params[:attempt_answers_attributes])
    # attempt_params.merge(submitted: true, correct_answers_count: result[:correct_answers], incorrect_answers_count: result[:incorrect_answers])
    attempt_params.merge(submitted: true)
  end
end
