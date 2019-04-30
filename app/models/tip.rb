class Tip < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  validates :title, presence: true  
  validates :user_id, presence: true
  validates :topic_id, presence: true
  validates :link, presence: true
  validates :benefit, presence: true 
  validates :tip_type, presence: true 
end
