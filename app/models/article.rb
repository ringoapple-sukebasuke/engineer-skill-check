class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true
  validates :Author, presence: true
  scope :active, lambda {
    where(deleted_at: nil)
  }
end
