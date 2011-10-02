class AddEndedAtToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :ended_at, :timestamp
  end
end
