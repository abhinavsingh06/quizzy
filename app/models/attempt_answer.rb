class AttemptAnswer < ApplicationRecord
  belongs_to :question
  belongs_to :attempt
  validates :answer, presence: true
  validates :attempt_id, uniqueness: { scope: :question_id }
end
