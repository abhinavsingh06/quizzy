class Attempt < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  belongs_to :quiz, foreign_key: :quiz_id
  validates :submitted, presence: true
  validates :user_id, uniqueness: { scope: :quiz_id }
end
