class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, index: true, unique: true
      t.string :password_digest
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
