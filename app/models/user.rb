class User < ApplicationRecord
  has_many :topics 
  has_many :tips 
  has_many :tip_ratings 
  
  attr_accessor :remember_token
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save { self.email = email.downcase }
  has_secure_password
  validates :bootcamp_name, presence: true 
  validates :name, presence: true, length: { maximum: 255} 
  validates :email, presence: true, length: { maximum: 255}, format:  { with: VALID_EMAIL_REGEX }, uniqueness:{ case_sensitive: false }
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, allow_nil: true 

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? 
      BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def self.new_token
    SecureRandom.urlsafe_base64  
  end 

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end


  def forget 
    update_attribute(:remember_digest, nil)
  end 

  def feed 
    Tip.where('user_id = ?', id)
  end 

end
