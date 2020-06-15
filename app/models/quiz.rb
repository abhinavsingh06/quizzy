class Quiz < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  has_many :questions, dependent: :destroy
  validates :name, presence: true, length: { minimum: 4 }
  validates :slug, uniqueness: true
end
