class QuestionMultipleChoice < ApplicationRecord
  belongs_to :question, foreign_key: :question_id, optional: true
  validates_with QuestionOptionValidator
end
