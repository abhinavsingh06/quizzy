class QuizzesController < ApplicationController
  before_action :ensure_user_logged_in
  before_action :load_quiz, only: [:show, :edit, :update, :destroy]

  def index
    @quizzes = current_user.quizzes
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
    @questions = @quiz.questions.joins(:question_multiple_choice).eager_load(:question_multiple_choice)
    @questions = @questions.as_json(include: { question_multiple_choice: { only: :options } })
  end

  def edit
    render
  end

  def update
    if @quiz.update(quiz_params)
      if @quiz.slug
        @quiz.generate_slug
        @quiz.save!
      else
        render status: :unprocessable_entity, json: { errors: ["Failed to publish URL!"] }
      end
      flash[:success] = "Succesfully updated the quiz name."
      render status: :ok, json: { notice: "Successfully updated quiz name." }
    else
      render status: :unprocessable_entity, json:{ errors: @quiz.errors.full_messages }
    end
  end

  def destroy
    if @quiz.destroy
      flash[:success] = "Succesfully deleted quiz."
      render status: :ok, json: { notice: "Successfully deleted quiz." }
    else
      render status: :unprocessable_entity, json: { errors: @quiz.errors.full_messages }
    end
  end

  private 

  def quiz_params
    params.require(:quiz).permit(:name)
  end

  def load_quiz
    @quiz = Quiz.find(params[:id]) rescue not_found
  end
end
