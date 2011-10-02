class VotesController < ApplicationController
  def create
    require_params :vote
    @vote = Vote.new params[:vote]
    
    if @vote.save!
      redirect_to :back
    end
  end
end