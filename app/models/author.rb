class Author < ApplicationRecord
  
  has_many :posts
  
  validates :fname, :lname, :email, presence: true
  
 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence: true, length: {maximum: 105},
        uniqueness: { case_sensitive: false },
        format: { with: VALID_EMAIL_REGEX } 
  
  validates :thumbnail, allow_blank: true, 
      format: {with: %r{\.(gif|jpg|png)\Z}i,
        message: 'must be a URL for GIF, JPG or PNG image.'}
  
  
end
