class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.string :name
      t.string :category
      t.date :date
      t.time :time
      t.integer :duration
      t.text :description
      t.integer :price
      t.string :instructor
      t.references :studio, null: false, foreign_key: true
      t.integer :limit_attendees

      t.timestamps
    end
  end
end
