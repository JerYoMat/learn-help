class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.string :title
      t.integer :course_order
      t.references :user, foreign_key: true
      t.string :course_name 
      t.integer :course_version 
      t.timestamps
    end
  end
end
