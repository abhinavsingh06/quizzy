class QuizzesController < ApplicationController
  before_action :ensure_user_not_logged_in

  def index
    render
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = current_user.quizzes.build(quiz_params)
    if @quiz.save
      flash[:success] = "Succesfully created the quiz."
      render status: :ok, json: { notice: "Succesfully created the quiz." }
    else 
      @quiz.errors.full_messages.each do |message|
        flash.now[:danger] ||= message
      end
      render status: :unprocessable_entity, json: { errors: flash }
    end
  end

  private 

  def quiz_params
    params.require(:quiz).permit(:name)
  end
end
