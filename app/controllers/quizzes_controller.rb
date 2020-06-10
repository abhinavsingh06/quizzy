class QuizzesController < ApplicationController
  before_action :ensure_user_not_logged_in
  before_action :load_quiz, only: [:show, :edit, :update, :destroy]

  def index
    @quizzes = Quiz.all
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
      render status: :unprocessable_entity, json: { errors: @quiz.errors.full_messages }
    end
  end

  def show
    render
  end

  def edit
    render
  end

  def update
    if @quiz.update(quiz_params)
      render status: :ok, json: { notice: "Successfully updated quiz name." }
    else
      render status: :unprocessable_entity, json:{ errors: @task.errors.full_messages }
    end
  end

  def destroy
    if @quiz.destroy
      render status: :ok, json: { notice: "Successfully deleted task." }
    else
      render status: :unprocessable_entity, json: { errors: @task.errors.full_messages }
    end
  end

  private 

  def quiz_params
    params.require(:quiz).permit(:name, :user_id)
  end

  def load_quiz
    @quiz = Quiz.find(params[:id])
    rescue ActiveRecord::RecordNotFound => errors
      render json: {errors: errors}
  end
end
