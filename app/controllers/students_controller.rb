class StudentsController < ApplicationController
  def view
    @room = Room.find(params[:room_id])
    @question = Question.new
  end
end