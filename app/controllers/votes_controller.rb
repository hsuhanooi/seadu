class VotesController < ApplicationController
  def create
    require_params :vote
    @vote = Vote.new params[:vote]
    save_and_render_status(@vote)
  end
end