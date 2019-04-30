class CreateTips < ActiveRecord::Migration[5.2]
  def change
    create_table :tips do |t|
      t.belongs_to :topic
      t.string :title
      t.string :link
      t.text :benefit
      t.string :tip_type 
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
