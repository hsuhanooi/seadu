module ApplicationHelper
  def render_vibe_chart(room)
    render :partial => "charts/vibe_chart", :locals => {:room => room}
  end
  
  def render_room(room)
    render :partial => "rooms/room", :locals => {:room => room}
  end
end
