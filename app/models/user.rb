class User < ApplicationRecord
  has_many :topics 
  has_many :tips 
  has_many :tip_ratings 
  has_many :active_relationships, 
    class_name:  "Relationship",
    foreign_key: "follower_id",
    dependent:   :destroy
  has_many :passive_relationships, 
    class_name:  "Relationship",
    foreign_key: "followed_id",
    dependent:   :destroy
  
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

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

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end


end
