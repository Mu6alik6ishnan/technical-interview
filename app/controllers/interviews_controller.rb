class InterviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :unless_interview_claimed, :only => :show


  def claim
    claimed_interview = Interview.first
    current_user.interviews<<claimed_interview
    redirect_to interview_path(claimed_interview)
  end

  def show
    @interviews = current_user.interviews
  end

  private

  helper_method :current_interview

  def current_interview
    @current_interview ||= Interview.find(params[:id])
  end

  def unless_interview_claimed
    unless current_interview.claimed? current_user
      render :text => "You must claim this interview before viewing it.",
      :status => :forbidden
    end
  end

end