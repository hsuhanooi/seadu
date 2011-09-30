class RoomManager
  
  attr_reader :rooms
  
  def initialize
    @rooms = {}
  end
  
  def add_room (name)
    room = Room.new(name)
    @rooms[name] = room
  end
  
  def get_room (name)
    return @rooms[name]
  end
  
end