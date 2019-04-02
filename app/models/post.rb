require 'models/anonimizer'

class Post < ApplicationRecord
  
  belongs_to :author
  
  enum status: [:published, :unpublished]
  
  validates :title, presence: true, length: {minimum: 5, maximum: 80}
  
  validates :article, presence: true, length: {minimum: 20, maximum: 600}

  validates :likes, numericality: {greater_than_or_equal_to: 0}
  
end
