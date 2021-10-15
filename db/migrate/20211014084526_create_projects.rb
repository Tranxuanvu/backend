class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.date :start_date, index: true
      t.date :end_date
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
