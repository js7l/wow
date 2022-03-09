class AddLevelToSessions < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :level, :string
  end
end
