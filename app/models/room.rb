class Room
  
  attr_reader :name, :speaker, :audience, :mood
  
  def initialize (name)
    @name = name
    @speaker = nil
    @audience = {}
    
    @mood = {}
  end
  
  def add_audience (audience)
    raise "Invalid audience -- no Id" unless audience.id
    @audience[audience.id] = audience
  end
  
  def find_audience (user_id)
    return @audience[user_id]
  end
  
  def submit_mood (user_id, answer)
    raise "Audience isn't part of this room [#{room_name}]" unless find_audience(user_id)
    @mood[user_id] = answer
  end
  
end