class AudienceController < ApplicationController

  def home
    @room_name = "startupweekend"
  end

  def join_room
    room_name = params[:room_name]
    
    # Find Room
    room_manager = RoomManagerStore.instance.room_manager
    room = room_manager.get_room(room_name)
    raise "Room with name [#{name}] doesn't exist" unless room
    
    # Add Audience To Room
    if session[:user_id].blank?
      session[:user_id] = SecureRandom.hex(10)
    end
    
    audience = room.find_audience(session[:user_id])
    raise "Already joined this room" if audience
    
    audience = User.new
    audience.id = session[:user_id]
    
    room.add_audience(audience)
    
    respond_to do |format|
      format.json { render :json => room.to_json }
    end
  end
  
  def submit_mood
    room_name = params[:room_name]
    answer = params[:answer]
    raise "User hasn't joined the room [#{room_name}]" unless session[:user_id]
    raise "Missing submission [#{answer}]" unless answer
    
    # Find Room
    room_manager = RoomManagerStore.instance.room_manager
    room = room_manager.get_room(room_name)
    raise "Room with name [#{name}] doesn't exist" unless room
    
    # Answer Poll
    room.submit_mood(session[:user_id], answer)
    
    respond_to do |format|
      format.json { render :json => room.mood.to_json }
    end
  end

end