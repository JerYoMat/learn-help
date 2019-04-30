class Topic < ApplicationRecord
  belongs_to :user
  has_many :tips 
  validates :course_order, presence: true 
  validates :user_id, presence: true 
  validates :course_name, presence: true 
  validates :course_version, presence: true 
end
