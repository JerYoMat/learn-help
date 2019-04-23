class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :provider_id, default: "000001"
      t.string :provider, default: "learnHELP"
      t.timestamps
    end
  end
end
