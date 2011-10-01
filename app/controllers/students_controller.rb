class StudentsController < ApplicationController
  def view
    @room = Room.find params[:room_id]
    @questions = Question.select(
      "questions.*, COUNT(votes.id) as votes_count"
    ).joins(
      "JOIN votes on votes.question_id = questions.id"
    ).group(
      "votes.question_id"
    ).where("questions.room_id=#{@room.id}")
    
    if mobile?
      render :template => "students/mobile"
    end
  end
end