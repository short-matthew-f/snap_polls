class VotesController < ApplicationController
  def create
    @response = Response.find(vote_params[:response_id])
    @poll = @response.poll
    
    if current_user.instructor?
      @poll.close!
      @response.is_correct!
    else
      @vote = Vote.new(user: current_user, response: @response)
      @vote.save
    end
    
    redirect_to @poll
  end
  
  private
  
  def vote_params
    params.require(:vote).permit(:response_id)
  end
end


# def complete
#   @poll = Poll.includes(:responses).find(params[:id])
#   @chosen_response = Response.find(params[:response_id])
#
#   if current_user.instructor?
#     @poll.close!(@chosen_response)
#   else
#     @vote = Vote.new(user: current_user, response: @chosen_response)
#   end
#
#   redirect_to completed_polls_url
# end