class Wmgr::OverviewsController < ApplicationController
  before_filter :authenticate_user!
  before_filter do
    redirect_to :denied unless current_user.admin?
  end

  def index
    @summary = Family.get_summary
  end

  def search
    search = params[:search]
    @results = Family.joins(:members).where("lower(people.first) like ? or lower(people.last) like ?", "%#{search.downcase}%", "%#{search.downcase}%")
  end

end