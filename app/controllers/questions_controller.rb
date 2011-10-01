class QuestionsController < ApplicationController
  def create
    require_params :question
    @question = Question.new params[:question]
    save_and_render_status(@question)
  end
end