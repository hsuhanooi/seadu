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
      @room.save
      redirect_to :action => :show, :id => @room.id
    else
      render :action => :new
    end
  end
  
  def show
    @room = Room.find params[:id]
  end  
end