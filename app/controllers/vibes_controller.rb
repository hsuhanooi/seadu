class VibesController < ApplicationController
  def create
    require_params :room_id, :type_key
    @vibe = Vibe.new(
      :room_id => params[:room_id],
      :type_key => params[:type_key]
    )
    save_and_render_status(@vibe)
  end
end