class TeacherSessionsController < ApplicationController
  def create
    @session = TeacherSession.new params[:session]
    
    if @session.save
      session[:teacher_id] = @session.teacher.id
      redirect_to rooms_url
    else
      flash[:error] = "Invalid username and/or password"
      redirect_to new_teacher_sessions_url
    end
  end
end
