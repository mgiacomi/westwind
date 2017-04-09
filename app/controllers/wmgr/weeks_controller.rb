class Wmgr::WeeksController < ApplicationController
  before_filter :authenticate_user!
  before_filter do
    redirect_to :denied unless current_user.admin?
  end

  def index
    @week_number = params[:id].nil? ? '1' : params[:id]

    @week = Family.where(week: @week_number).order(:lottery)
    @week_adults_f = @week.select{ |f| !f.adults.nil? }.map{ |f| f.adults}.reduce {|sum, n| sum + n}
    @week_adults_c = People.joins(:family).where("families.week=? and grade='Adult'", @week_number).count
    @week_kids_f = @week.select{ |f| !f.kids.nil? }.map{ |f| f.kids}.reduce {|sum, n| sum + n}
    @week_kids_c = People.joins(:family).where("families.week=? and grade != 'Adult'", @week_number).count
    @week_total_count = @week.length
    @week_onk_members = @week.select{ |f| f.onk_member == true }.map{ |f| f.adults}.reduce {|sum, n| sum + 1}
    @week_deposits = @week.select{ |f| f.total_paid > 99 }.map{ |f| f.adults}.reduce {|sum, n| sum + 1}
    @week_onk_deposits = @week.select{ |f| f.total_paid > 99 }.map{ |f| f.adults}.reduce {|sum, n| sum + 1}
    @week_total_due = @week.map{ |f| f.amount_due}.reduce {|sum, n| sum + n}
    @week_total_paid = @week.map{ |f| f.total_paid}.reduce {|sum, n| sum + n}

    @week_name = @week_number == '0' ? 'Wait List' : "Week #{@week_number}"
  end

end