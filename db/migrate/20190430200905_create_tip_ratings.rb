class CreateTipRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :tip_ratings do |t|
      t.belongs_to :user 
      t.belongs_to :tip 
      t.boolean :good_tip
      t.timestamps
    end
  end
end
