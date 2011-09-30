class RoomController < ApplicationController
  
  def rooms
    @room_manager = RoomManagerStore.instance.room_manager
  end
  
end