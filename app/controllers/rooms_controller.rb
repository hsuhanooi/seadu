class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end
  
  def new
    @room = Room.new
  end
  
  def create
    require_params :room
    @room = Room.new(params[:room])
    
    if @room.valid?
      render :action => :new
    else
      redirect_to :action => :show
    end
  end
  
  def show
    @room = Room.find params[:id]
  end
  
  def admin
    @room = Room.find params[:id]
  end
  
end