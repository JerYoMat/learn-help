class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :bootcamp_name
      t.string :provider_id
      t.string :provider, default: "learnHELP"
      t.timestamps
    end
  end
end
