class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def require_params *keys
    missing = keys.reject{|k| params.keys.include? k}
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
end
