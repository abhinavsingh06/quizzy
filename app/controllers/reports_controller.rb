class ReportsController < ApplicationController
  before_action :ensure_user_admin
  before_action :load_quiz, only: [:show]

  def index
    @quizzes = current_user.quizzes
  end

  def create
    job_id = CreateReportWorker.perform_async(current_user.id)
    render status: :ok, json: { processing: true, notice: "Processing", job_id: job_id }
  end
  
  def show
    @quizzes = current_user.quizzes
    @question = {}
    @quiz.questions.each do |question|
      @question[question.id] = { "description": question.description }
      @question[question.id]['count'] = {}
      @quiz.attempts.each do |attempt|
        attempt_answer = attempt.attempt_answers.find_by_question_id(question.id)
        if !attempt_answer.nil? && question.id == attempt_answer.question_id
          if @question[question.id]['count'].key?(attempt_answer.answer)
            @question[question.id]['count'][attempt_answer.answer] += 1
          else
            @question[question.id]['count'][attempt_answer.answer] = 1
          end
        end
      end
    end
  end

  private

  def load_quiz
    @quiz = current_user.quizzes.find(params[:id]) rescue not_found
  end
end
