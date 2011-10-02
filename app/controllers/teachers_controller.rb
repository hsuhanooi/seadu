class TeachersController < ApplicationController
  
  def view
    @room = Room.find(params[:room_id])
  end

  def create
    require_params :teacher
    @teacher = Teacher.new params[:teacher]
    
    if @teacher.save!
      redirect_to teachers_view_url(@teacher.rooms.first.id)
    end
  end
  
  def save
    
  end
  
end