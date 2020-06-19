class QuestionsChecker < ApplicationService
  attr_reader :questions, :answers

  def initialize(questions, answers)
    @questions = questions
    @answers = answers
    @correct_answers = 0
  end

  def call
    @questions.each do |question|
      answer = @answers.detect { |ans| ans["question_id"] == question["id"] }
      @correct_answers += 1 if check_question?(question, answer["answer"])
    end

    {
      correct_answers: @correct_answers,
      incorrect_answers: @questions.count - @correct_answers
    }
  end

  private
    def check_question?(question, answer)
      correct_option = question["question_multiple_choice"]["options"].detect do |option|
        option["is_correct"]
      end
      correct_option["value"] == answer
    end
end
