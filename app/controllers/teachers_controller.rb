class TeachersController < ApplicationController
  
  def view
    @room = Room.find(params[:room_id])
  end
  
end