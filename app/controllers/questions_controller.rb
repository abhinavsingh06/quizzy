class QuestionsController < ApplicationController
  before_action -> { load_quiz params[:quiz_id] }

  def new
    @question = Question.new
  end

  def create
    @question = @quiz.questions.build(question_params)
    if @question.save
      flash[:success] = "Successfully created the question!"
      render status: :ok, json: { notice: "Successfully created the question!" }
    else
      render status: :unprocessable_entity, json: { errors: @question.errors.full_messages}
    end
  end

  private

  def question_params
    params.require(:question).permit(:description, question_multiple_choice_attributes: [:options [:is_correct, :value]])
  end
end
