class Quiz < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  has_many :questions, dependent: :destroy
  validates :name, presence: true, length: { minimum: 4 }
  validates :slug, uniqueness: true, :allow_nil => true

  def generate_slug
    temp = slug = self.slug = ActiveSupport::Inflector.parameterize(self.name)
    count = 0
    while Quiz.exists?(slug: slug)
      count += 1
      slug = self.slug = "#{temp}-#{count}"
    end
    slug
  end
end
