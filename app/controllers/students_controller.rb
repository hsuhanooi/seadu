class StudentsController < ApplicationController
  def view
    if params[:room_id]
      @room = Room.find params[:room_id]
    elsif params[:name]
      @room = Room.find_by_name params[:name]
    end
    
    #Mark the user as visited the room
    @room.visit(session)
    
    @questions = @room.questions.highest_rated.page(params[:page])
    @question = Question.new(room: @room)

    if mobile?
      render :template => "students/mobile", :layout => "mobile"
    end
  end
  
end