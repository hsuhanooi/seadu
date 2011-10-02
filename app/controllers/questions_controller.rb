class QuestionsController < ApplicationController
  respond_to :js
  def index
    @questions = Question.where(params[:question]).includes(:votes).page(params[:page])
    
    respond_with(@questions)
  end
  
  def highest_rated
    @questions = Question.from_room(params[:room_id]).highest_rated.page(params[:page])
    @page = params[:page]
    @admin = true if params[:teacher].eql?('true')
    
    respond_with(@questions)
  end
  
  def most_recent
    @questions = Question.from_room(params[:room_id]).most_recent.page(params[:page])
    @page = params[:page]
    @admin = true if params[:teacher].eql?('true')
    
    respond_with(@questions)
  end

  def newly_created
    @questions = Question.from_room(params[:room_id]).after(params[:after]).most_recent.page(params[:page])
    @page = params[:page]
    
    respond_with(@questions)
  end
  
  def show
    @question = Question.find(params[:id])
    @page = params[:page]
    
    respond_with(@question)
  end
  
  def vote
    @question = Question.find(params[:id])
    @question.votes.create(vote_type: params[:vote_type])
  end
  
  def create
    require_params :question
    @question = Question.new(params[:question])
    flash[:notice] = "Comment successfully created" if @question.save
    
    if request.xhr?
      respond_with(@question, :layout => false) 
    else
      redirect_to students_view_url(params[:question][:room_id])
    end
  end
  
  def hide_question
    question = Question.find(params[:id])
    question.status = 'done'
    if question.save
      render :text => "Successfully hid question."
    else
      render :text => "Failed to hide question.", :status => 400
    end
  end
end