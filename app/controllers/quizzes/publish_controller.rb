class Quizzes::PublishController < ApplicationController
  before_action -> { load_quiz params[:id] }
  before_action :quiz_has_questions?

  def update
    unless @quiz.slug
      @quiz.update(slug: @quiz.generate_slug)
      flash.now[:success] = "Successfully published the quiz!"
      render status: :ok, json: { notice: flash, slug: @quiz.slug }
    end
  end

  private
  
  def quiz_has_questions?
    if @quiz.questions.empty?
      flash.now[:danger] = "Please add questions!"
      render status: :unprocessable_entity, json: { success: false, errors: flash }
    end
  end
end
