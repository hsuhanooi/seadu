class TeachersController < ApplicationController
  
  def view
    @room = Room.find(params[:room_id])
    @questions = @room.questions.highest_rated.page(params[:page])
    @admin = true
  end

  def create
    require_params :teacher
    @teacher = Teacher.new params[:teacher]
    
    if @teacher.save!
      redirect_to teachers_view_url(@teacher.rooms.first.id)
    end
    @admin = true
  end
  
  def save
    
  end
  
end