class StudentsController < ApplicationController
  def view
    @room = Room.find params[:room_id]
    
    #Mark the user as visited the room
    @room.visit(session)
    
    @questions = @room.questions.highest_rated
    
    if mobile?
      render :template => "students/mobile"
    end
  end
end