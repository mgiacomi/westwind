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

  def families
    @families = Family.where("week > 0").order(:week)
    headers['Content-Disposition'] = "attachment; filename=\"families.csv\""
    headers['Content-Type'] ||= 'text/csv'
  end

  def people
    @people = People.joins(:family).where("families.week > 0").order('families.week')
    headers['Content-Disposition'] = "attachment; filename=\"people.csv\""
    headers['Content-Type'] ||= 'text/csv'
  end

  def volunteers
    summary = Family.get_summary

    if params[:week] == "1"
      @week = "Week 1"
      @volunteers = summary[:volunteers][:week1]
    end
    if params[:week] == "2"
      @week = "Week 2"
      @volunteers = summary[:volunteers][:week2]
    end
    if params[:week] == "3"
      @week = "Week 3"
      @volunteers = summary[:volunteers][:week3]
    end
  end

  def dietary
    summary = Family.get_summary

    if params[:week] == "1"
      @people = summary[:dietary_restrictions][:week1]
    end
    if params[:week] == "2"
      @people = summary[:dietary_restrictions][:week2]
    end
    if params[:week] == "3"
      @people = summary[:dietary_restrictions][:week3]
    end
  end

  def attendance
    @families = Family.where('week=?', params[:week])
  end

end