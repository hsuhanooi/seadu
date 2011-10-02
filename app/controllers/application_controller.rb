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
end
