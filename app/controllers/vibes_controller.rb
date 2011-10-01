class VibesController < ApplicationController
  def create
    room_id = params[:room_id]
    vibe_type = params[:vibe_type]
    
    @vibe = Vibe.new(:room_id => room_id, :vibe_type => vibe_type)
    
    if @vibe.valid?
      @vibe.save
      respond_to do |format|
        format.html { redirect_to students_view_url(room_id) }
        format.js { render :text => "Added vibe successfully" }
      end
    else
      respond_to do |format|
        format.html { redirect_to students_view_url(room_id) }
        format.js { render :text => "There was an error adding your vibe.", :status => 400 }
      end
    end
  end
end