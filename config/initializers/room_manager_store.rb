require 'singleton'

class RoomManagerStore
  include Singleton
  
  attr_reader :room_manager
  
  def initialize
    puts "Initialize RoomManagerStore"
    @room_manager = RoomManager.new
  end
  
end

store = RoomManagerStore.instance
room_manager = store.room_manager
room_manager.add_room("startupweekend")