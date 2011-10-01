class RoomController < ApplicationController
  def new
    @room = Room.new
  end

  def index
    @rooms = Room.all
  end
  
  def create
    require_params :name
    @room = Room.find_or_create_by_name params[:name]
    redirect_to :action => :teacher, :id => @room.id
  end
  
  def teacher
    @room = Room.find params[:id]
  end
  
  def student
    @room = Room.find params[:id]
  end
end