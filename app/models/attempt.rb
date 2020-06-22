class Attempt < ApplicationRecord
  has_many :attempt_answers
  accepts_nested_attributes_for :attempt_answers, update_only: true
  belongs_to :user, foreign_key: :user_id, optional: true
  belongs_to :quiz, foreign_key: :quiz_id
  validates :user_id, uniqueness: { scope: :quiz_id }
  validates :correct_answers_count, presence: true
  validates :incorrect_answers_count, presence: true
end
