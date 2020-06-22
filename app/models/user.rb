class User < ApplicationRecord

  has_many :quizzes, dependent: :restrict_with_error
  has_many :attempts
  before_save { email.downcase! }
  enum role: [:regular_user, :administrator]
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :first_name, :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
  validates :role, presence: true, inclusion: roles.keys 
  has_secure_password
  validates :password, presence: true, length: { maximum: 8 }, allow_nil: true
end
