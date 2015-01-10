class PollsController < ApplicationController
  before_action :authenticate_user!
  
  load_and_authorize_resource
  
  def new
    @poll = Poll.new
    @poll.responses.build
  end
  
  def create    
    @poll = Poll.new(poll_params)
    @poll.tag_list.map! &:downcase
    
    if @poll.save
      redirect_to @poll
    else
      flash.now[:alert] = @poll.errors.full_messages.to_sentence
      @poll.responses.build
      render :new
    end
  end
  
  def show
    if current_user.has_voted_on?(@poll) || !@poll.active?
      @poll = Poll.includes(responses: :votes).find(params[:id])
      
      @responses = @poll.responses.sort_by do |x| 
        [ -x.votes.size, x.correct? ? 1 : 0 ]
      end
      
      @vote_count = @responses.map(&:votes).map(&:to_a).flatten.count
      
      render :results
    else
      @poll = Poll.includes(:responses).find(params[:id])
      @responses = @poll.responses.shuffle
      @vote = Vote.new
      
      render :vote
    end
  end
  
  def active
    @polls = Poll.where(active: true)
  end
  
  def completed
    @polls = Poll.where(active: false)
  end
  
  private
  
  def poll_params
    params.require(:poll).permit( :question, :tag_list, responses_attributes: [:content] )
  end  
end
