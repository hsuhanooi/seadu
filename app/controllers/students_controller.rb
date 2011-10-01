class StudentsController < ApplicationController
  def view
    @room = Room.find params[:room_id]
    @questions = room.questions.highest_rated
    
    if mobile?
      render :template => "students/mobile"
    end
  end
end