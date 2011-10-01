class QuestionsController < ApplicationController
  def create
    require_params :content, :room_id
    @question = Question.new(
      :content => params[:content],
      :room_id => params[:room_id]
    )
    save_and_render_status(@question)
  end
end