class RoomController < ApplicationController
  
  def index
    @rooms = Room.all
  end
  
  def teacher

  end
  
  def student
    
  end
end