class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save { self.email = email.downcase }
  has_secure_password
 
  validates :name, presence: true, length: { maximum: 255} 
  validates :email, presence: true, length: { maximum: 255}, format:  { with: VALID_EMAIL_REGEX }, uniqueness:{ case_sensitive: false }
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, allow_nil: true 

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? 
      BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
end
