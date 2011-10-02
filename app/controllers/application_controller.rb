class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def require_params(*keys)
    puts params.keys.inspect
    missing = keys.reject{|k| params.keys.include? k.to_s}
    unless missing.empty?
      raise "Missing following params: #{missing.join(',')}" 
    end
  end
  
  def save_and_render_status obj
    if obj.save!
      render :json => {:status => "success"}
    else
      render :json => {:status => "error"}
    end
  end
  
  def mobile?
    return true if Rails.env == "development" && params[:mobile]
    request.user_agent =~ /Mobile|webOS/
  end
  
  def current_teacher
    teacher_id = session[:teacher_id]
    @current_teacher ||= teacher_id && Teacher.find(teacher_id)
  end
  
  def require_teacher
    unless current_teacher
      flash[:error] = "Please login to view this page"
      redirect_to new_teacher_sessions_url(:return_to => request.request_uri)
    end
  end
end
