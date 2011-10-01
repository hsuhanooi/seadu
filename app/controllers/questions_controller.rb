class QuestionsController < ApplicationController
  respond_to :js
  def index
    @questions = Question.where(params[:question]).page(params[:page])
    
    respond_with(@questions)
  end
  
  def highest_rated
    @questions = Question.where(room_id: params[:room_id]).highest_rated.page(params[:page])
    
    respond_with(@questions)
  end
  
  def most_recent
    @questions = Question.where(room_id: params[:room_id]).most_recent.page(params[:page])
    
    respond_with(@questions)
  end

  def show
    @question = Question.find(params[:id])
    
    respond_with(@questions)
  end
  
  def create
    @question = Question.new(params[:question])
    
    flash[:notice] = "Comment successfully created" if @question.save
    respond_with(@question, :layout => false) if request.xhr?
  end
end