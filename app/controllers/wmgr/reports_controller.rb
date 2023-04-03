class Wmgr::ReportsController < ApplicationController
  before_action do
    redirect_to :denied unless (current_user&.admin?) || (current_family&.host?)
  end

  def weekly
    @families = Family.where("week = ?", params[:week])
    @people = People.joins(:family).where("families.week = ?", params[:week])
    render :xlsx => "weekly", :filename => "week#{params[:week]}_report.xlsx"
  end

end