class AddNumListenersToRoom < ActiveRecord::Migration
  def change
    add_column :rooms, :num_listeners, :int
  end
end
