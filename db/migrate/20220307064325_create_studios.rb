class CreateStudios < ActiveRecord::Migration[6.1]
  def change
    create_table :studios do |t|
      t.string :address
      t.string :name
      t.string :email
      t.string :phone_number
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
