class TipRating < ApplicationRecord
  belongs_to :tip 
  belongs_to :user 
  validates :user_id, presence: true 
  validates :tip_id, presence: true 
  validates :good_tip, presence: true 
  validates_uniqueness_of :user_id, scope: :tip_id
end
