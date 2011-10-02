class VibesController < ApplicationController
  
  def randomize_chart
    room_id = params[:room_id]
    Vibe.delete_all("room_id = #{room_id}")
    room = Room.find(room_id)
    room.mock
    redirect_to :action => :chart, :room_id => room_id
  end

  def chart_data
    room_id = params[:room_id]
    @room = Room.find(room_id)
    render :text => Vibe.chart_series(@room.id)
  end
  
  def chart_live
    room_id = params[:room_id]
    @room = Room.find(room_id)
    render :text => Vibe.chart_live(@room, Time.now)
  end
  
  def chart
    room_id = params[:room_id]
    @room = Room.find(room_id)
  end
  
  def create
    room_id   = params[:room_id]
    vibe_type = params[:vibe_type]
    @vibe = Vibe.new(:room_id => room_id, :vibe_type => vibe_type)
    
    if @vibe.save
      respond_to do |format|
        format.html { redirect_to students_view_url(room_id) }
        format.js { render :text => "Succesfully added your vibe."}
      end
    else
      respond_to do |format|
        format.html { redirect_to students_view_url(room_id) }
        format.js { render :text => "There was an error adding your vibe.", :status => 400 }
      end
    end
  end
end