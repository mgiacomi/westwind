class Wmgr::WeeksController < ApplicationController
  before_filter :authenticate_user!
  before_filter do
    redirect_to :denied unless current_user.admin?
  end

  def index
    @week1 = Family.where(week: 1).order(:lottery)
    @week2 = Family.where(week: 2).order(:lottery)
    @week3 = Family.where(week: 3).order(:lottery)
    @waitlist = Family.where(week: 0).order(:lottery)
  end

end