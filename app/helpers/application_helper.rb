module ApplicationHelper
  def render_vibe_chart(room)
    render :partial => "charts/vibe_chart", :locals => {:room => room}
  end
end
