class Quiz < ApplicationRecord

  belongs_to :user, foreign_key: :users_id
  validates :name, presence: true, length: { minimum: 4 }
end
