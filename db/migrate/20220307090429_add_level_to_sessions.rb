class AddLevelToSessions < ActiveRecord::Migration[6.1]
  def change
    add_column :sessions, :level, :string
  end
end
