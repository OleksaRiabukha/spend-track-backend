class User < ApplicationRecord
  has_secure_password
  before_save { email.downcase! }
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :first_name,
            :last_name,
            presence: true,
            length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, 
                     format: { with: VALID_EMAIL },
                     uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true
end
