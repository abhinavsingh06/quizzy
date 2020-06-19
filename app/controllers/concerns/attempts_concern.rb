module AttemptsConcern
  extend ActiveSupport::Concern

  included do
    helper_method :load_quiz, :load_questions_with_options, :ensure_participant_logged_in, :quiz_already_attempted, :check_questions
  end

  def load_quiz
    @quiz = Quiz.find_by!(slug: params[:quiz_slug])
  end

  def load_questions_with_options
    questions = @quiz.questions.joins(:question_multiple_choice).eager_load(:question_multiple_choice)
    @questions = questions.as_json(include: { question_multiple_choice: { only: :options } })
  end

  def ensure_participant_logged_in
    if session[:attempt_id]
      @attempt ||= Attempt.find(session[:attempt_id])
      @participant ||= User.find(@attempt.user_id)
    else
      respond_to do |format|
        format.html do
          flash[:danger] = "Please Log In"
          redirect_to new_quiz_attempt_path(params[:quiz_slug])
        end
        format.json { render status: :unauthorized, json: { errors: "You need to login" } }
      end
    end
  end

  def ensure_quiz_not_attempted
    if @attempt.submitted
      redirect_to quiz_attempt_path(@quiz.slug, @attempt.id)
    end
  end
end  
