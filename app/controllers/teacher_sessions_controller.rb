class TeacherSessionsController < ApplicationController
  def create
    @session = TeacherSession.new params[:session]
    
    if @session.save
      return_to = params[:return_to]
      session[:teacher_id] = @session.teacher.id
      session.delete(:return_to)
      redirect_to (return_to || rooms_url)
    else
      flash[:error] = "Invalid username and/or password"
      redirect_to new_teacher_sessions_url
    end
  end
  
  def destroy
    session.delete(:teacher_id)
    flash[:notice] = "Logout successful"
    redirect_to root_url
  end
end
