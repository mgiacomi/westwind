class Wmgr::OverviewsController < ApplicationController
  before_action :authenticate_user!
  before_action do
    redirect_to :denied unless current_user.admin?
  end

  def index
    @summary = Family.get_summary
  end

  def search
    search = params[:search]
    @results = Family.joins(:members).where("lower(people.first) like ? or lower(people.last) like ?", "%#{search.downcase}%", "%#{search.downcase}%").distinct
  end

  def onkmember_complete
    summary = Family.get_summary

    if params[:week] == "1"
      @week = "Week 1"
      @results = summary[:onk_members][:week1y]
    end
    if params[:week] == "2"
      @week = "Week 2"
      @results = summary[:onk_members][:week2y]
    end
    if params[:week] == "3"
      @week = "Week 3"
      @results = summary[:onk_members][:week3y]
    end

    @title = "ONK Members"
    render action: "list"
  end

  def onkmember_incomplete
    summary = Family.get_summary

    if params[:week] == "1"
      @week = "Week 1"
      @results = summary[:onk_members][:week1n]
    end
    if params[:week] == "2"
      @week = "Week 2"
      @results = summary[:onk_members][:week2n]
    end
    if params[:week] == "3"
      @week = "Week 3"
      @results = summary[:onk_members][:week3n]
    end

    @title = "Missing ONK Membership"
    render action: "list"
  end

  def deposit_paid
    summary = Family.get_summary

    if params[:week] == "1"
      @week = "Week 1"
      @results = summary[:deposit_paid][:week1y]
    end
    if params[:week] == "2"
      @week = "Week 2"
      @results = summary[:deposit_paid][:week2y]
    end
    if params[:week] == "3"
      @week = "Week 3"
      @results = summary[:deposit_paid][:week3y]
    end

    @title = "Paid Deposit"
    render action: "list"
  end

  def deposit_unpaid
    summary = Family.get_summary

    if params[:week] == "1"
      @week = "Week 1"
      @results = summary[:deposit_paid][:week1n]
    end
    if params[:week] == "2"
      @week = "Week 2"
      @results = summary[:deposit_paid][:week2n]
    end
    if params[:week] == "3"
      @week = "Week 3"
      @results = summary[:deposit_paid][:week3n]
    end

    @title = "Unpaid Deposit"
    render action: "list"
  end

  def fullpayment_paid
    summary = Family.get_summary

    if params[:week] == "1"
      @week = "Week 1"
      @results = summary[:paid_full][:week1y]
    end
    if params[:week] == "2"
      @week = "Week 2"
      @results = summary[:paid_full][:week2y]
    end
    if params[:week] == "3"
      @week = "Week 3"
      @results = summary[:paid_full][:week3y]
    end

    @title = "Full Payment"
    render action: "list"
  end

  def fullpayment_unpaid
    summary = Family.get_summary

    if params[:week] == "1"
      @week = "Week 1"
      @results = summary[:paid_full][:week1n]
    end
    if params[:week] == "2"
      @week = "Week 2"
      @results = summary[:paid_full][:week2n]
    end
    if params[:week] == "3"
      @week = "Week 3"
      @results = summary[:paid_full][:week3n]
    end

    @title = "Unpaid Payment"
    render action: "list"
  end

  def waivers_complete
    summary = Family.get_summary

    if params[:week] == "1"
      @week = "Week 1"
      @results = summary[:waivers][:week1y]
    end
    if params[:week] == "2"
      @week = "Week 2"
      @results = summary[:waivers][:week2y]
    end
    if params[:week] == "3"
      @week = "Week 3"
      @results = summary[:waivers][:week3y]
    end

    @title = "Completed Waivers"
    render action: "list"
  end

  def waivers_incomplete
    summary = Family.get_summary

    if params[:week] == "1"
      @week = "Week 1"
      @results = summary[:waivers][:week1n]
    end
    if params[:week] == "2"
      @week = "Week 2"
      @results = summary[:waivers][:week2n]
    end
    if params[:week] == "3"
      @week = "Week 3"
      @results = summary[:waivers][:week3n]
    end

    @title = "Missing Waivers"
    render action: "list"
  end

  def dietary_complete
    summary = Family.get_summary

    if params[:week] == "1"
      @week = "Week 1"
      @results = summary[:dietary][:week1y]
    end
    if params[:week] == "2"
      @week = "Week 2"
      @results = summary[:dietary][:week2y]
    end
    if params[:week] == "3"
      @week = "Week 3"
      @results = summary[:dietary][:week3y]
    end

    @title = "Completed Dietary Info"
    render action: "list"
  end

  def dietary_incomplete
    summary = Family.get_summary

    if params[:week] == "1"
      @week = "Week 1"
      @results = summary[:dietary][:week1n]
    end
    if params[:week] == "2"
      @week = "Week 2"
      @results = summary[:dietary][:week2n]
    end
    if params[:week] == "3"
      @week = "Week 3"
      @results = summary[:dietary][:week3n]
    end

    @title = "Incomplete Dietary Info"
    render action: "list"
  end

end