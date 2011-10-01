class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end
  
  def new
    @room = Room.new
  end
  
  def create
    @room = Room.new(params[:room])
    
    if @room.valid?
      @room.save
      redirect_to teachers_view_url(@room.id)
    else
      render :action => :new
    end
  end
  
  def list
    @rooms = Room.find(:all)
  end

  def show
    @room = Room.find(params[:id])
    @questions = @room.questions
    @question = Question.new(room: @room)
    
    if mobile?
      render :template => "rooms/mobile"
    end
  end  
end