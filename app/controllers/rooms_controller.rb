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
      @room.num_listeners = 1
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
    @questions = @room.questions.highest_rated.page(params[:page])
    # @questions = @room.questions.most_recent.page(params[:page])
    @question = Question.new(room: @room)
    @page = params[:page]
    @sort_order = 'highest_rated'
    
    if mobile?
      render :template => "students/mobile"
    end
  end
  
  def poll_listeners
    room = Room.find(params[:room_id])
    hash = {}
    hash[:listeners] = room.num_listeners
    render :text => hash.to_json
  end
  
  def finished_rooms
    @rooms = []
    created_at = Time.now - 3600 - rand(3600)
    ended_at = created_at + 1800 + rand(3600)
    ["Bma-Pitch-SpeakerBuddi-101", "Bma-Pitch-SpeakerBuddi-102", "Bma-Pitch-SpeakerBuddi-103", "Bma-Pitch-SpeakerBuddi-104", "Bma-Pitch-SpeakerBuddi-105", "Bma-Pitch-SpeakerBuddi-106"].each{|name|
      @rooms << Room.new(:name => "", :status => 'expired', :vibe_threshold => 15, :question_threshold => 15, :teacher_id => 1, :num_listeners => rand(100) + 50, :created_at => created_at, :updated_at => created_at, :ended_at => ended_at)
    }
  end
  
  def finish_room
    room = Room.find(params[:room_id])
    saved = room.finish_room
    
    respond_to do |format|
      format.html { 
        if saved
          # flash[:success] = "Room has been closed successfully."
          # redirect_to teachers_view_url(room.id)
          redirect_to finished_rooms_url(room.id)
        else
          flash[:error] = "There was a problem closing your room. Please try again."
          redirect_to teachers_view_url(room.id)
        end
      }
    end
  end
end