class PollsController < ApplicationController
  
  def new
    @poll = Poll.new
    @poll.responses.build
  end
  
  def create    
    @poll = Poll.new(poll_params)
    
    if @poll.save
      redirect_to @poll
    else
      render :new
    end
  end
  
  def show
    @poll = Poll.includes(:responses).find(params[:id])
  end
  
  def active
    @polls = Poll.where(active: true)
    
    render :index
  end
  
  def completed
    
  end
  
  def vote
    @poll = Poll.includes(:responses).find(params[:id])
  end
  
  def open
    @poll = Poll.find(params[:id])
    @poll.update_attribute(active: true)
    
    redirect_to show_poll_url(@poll)
  end
  
  def close
    @poll = Poll.find(params[:id])
    @poll.update(active: false)
    
    redirect_to show_poll_url(@poll)
  end
  
  private
  
  def poll_params
    params.require(:poll).permit( :question, responses_attributes: [:content] )
  end  
end
