class VotesController < ApplicationController
  def create
    require_params :question_id
    @vote = Vote.new(
      :room_id  => params[:question_id],
      :type_key => 0
    )
    save_and_render_status(@vote)
  end
end