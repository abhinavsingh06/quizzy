class Job < ApplicationRecord
  belongs_to :user
  validates :job_id, presence: true
  validates :filename, presence: true
end
