class Wmgr::OverviewsController < ApplicationController
  before_filter :authenticate_user!
  before_filter do
    redirect_to :denied unless current_user.admin?
  end

  def index
    @summary_k = get_summary_by_grade 0
    @summary_1 = get_summary_by_grade 1
    @summary_2 = get_summary_by_grade 2
    @summary_3 = get_summary_by_grade 3
    @summary_4 = get_summary_by_grade 4
    @summary_5 = get_summary_by_grade 5

    @summary_t = {
        setup: @summary_k[:setup] + @summary_1[:setup] + @summary_2[:setup] + @summary_3[:setup] + @summary_4[:setup] + @summary_5[:setup],
        registered: @summary_k[:registered] + @summary_1[:registered] + @summary_2[:registered] + @summary_3[:registered] + @summary_4[:registered] + @summary_5[:registered],
        minutes: @summary_k[:minutes] + @summary_1[:minutes] + @summary_2[:minutes] + @summary_3[:minutes] + @summary_4[:minutes] + @summary_5[:minutes],
        pledged: @summary_k[:pledged] + @summary_1[:pledged] + @summary_2[:pledged] + @summary_3[:pledged] + @summary_4[:pledged] + @summary_5[:pledged],
        collected: @summary_k[:collected] + @summary_1[:collected] + @summary_2[:collected] + @summary_3[:collected] + @summary_4[:collected] + @summary_5[:collected]
    }
  end

  def unregistered
    @students = Family.where("accepted_date is null")
    headers['Content-Disposition'] = "attachment; filename=\"unregistered_students.csv\""
    headers['Content-Type'] ||= 'text/csv'
  end

  def uncollected
    @pledges = Pledge.where("email_click_date is null")
    headers['Content-Disposition'] = "attachment; filename=\"uncollected_pledges.csv\""
    headers['Content-Type'] ||= 'text/csv'
  end

  def collected
    @pledges = Pledge.where("email_click_date is not null")
    headers['Content-Disposition'] = "attachment; filename=\"collected_pledges.csv\""
    headers['Content-Type'] ||= 'text/csv'
  end

  def pledge_email
    pledge = Pledge.find params[:id]
    GeneralMailer.pledge_payment(pledge).deliver

  end

  private

  def get_summary_by_grade grade

    setup = 0
    registered = 0
    minutes = 0
    pledged = 0
    collected = 0
    teachers = Array.new

    People.where("grade=?", grade).each do |teacher|
      tsetup = 0
      tregistered = 0
      tminutes = 0
      tpledged = 0
      tcollected = 0

      teacher.students.each do |student|
        tsetup += 1

        unless student.accepted_date.nil?
          tregistered += 1
        end

        tminutes += student.total_minutes_read

        student.pledges.each do |pledge|
          total_owed = pledge.total_owed
          unless total_owed.nil?
            tpledged += total_owed

            unless pledge.email_click_date.nil?
              tcollected += pledge.total_owed
            end
          end
        end
      end

      registered += tregistered
      setup += tsetup
      minutes += tminutes
      pledged += tpledged
      collected += tcollected

      teachers << {grade: teacher.grade, last: teacher.last, setup: tsetup, registered: tregistered, minutes: tminutes, pledged: tpledged, collected: tcollected}
    end

    {setup: setup, registered: registered, minutes: minutes, pledged: pledged, collected: collected, teachers: teachers}
  end

end