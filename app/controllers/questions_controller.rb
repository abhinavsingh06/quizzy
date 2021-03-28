class QuestionsController < ApplicationController
  before_action -> { load_quiz params[:quiz_id] }
  before_action :load_question, only: [:edit, :update, :destroy]

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

  def edit
    @question = @question.as_json(include: { question_multiple_choice: { only: :options } })
  end

  def update
    if @question.update(question_params)
      flash[:success] = "Successfully updated the question!"
      render status: :ok, json: { success: true, notice: "Successfully updated the question!" }
    else
      render status: :unprocessable_entity, json: { success: false, errors: @question.errors }
    end
  end

  def destroy
    if @question.destroy
      flash[:warning] = "Question deleted!"
      render status: :ok, json: { success: true, notice: "Successfully deleted the question!" }
    else
      render status: :bad_request, json: { success: false, errors: flash }
    end
  end

  private

  def question_params
    # params.require(:question).permit(:description, question_multiple_choice_attributes: [options: [:is_correct, :value]])
    params.require(:question).permit(:description, question_multiple_choice_attributes: [options: [:value]])
  end

  def load_question
    @question = @quiz.questions.find(params[:id])
  end
end
