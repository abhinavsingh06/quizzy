module AttemptsConcern
  extend ActiveSupport::Concern

  included do
    helper_method :load_quiz
  end

  def load_quiz
    @quiz = Quiz.find_by!(slug: params[:quiz_slug])
  end
end  
