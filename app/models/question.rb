class Question < ApplicationRecord
  belongs_to :quiz, foreign_key: :quiz_id
  has_one :question_multiple_choice
  accepts_nested_attributes_for :question_multiple_choice, update_only: true
  validates :description, presence: true
end
