class RoomsController < ApplicationController
  
  def new
    @room = Room.new
  end
  
  def create
    @room = Room.new(params[:room])
    
    if @room.valid?
      render :action => :new
    else
      redirect_to :action => :show
    end
  end
  
  def show
  end
  
end