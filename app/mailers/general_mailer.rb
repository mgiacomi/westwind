class GeneralMailer < ApplicationMailer

  def welcome_flyer student
    @student = student
    to = student.email2.nil? ? student.email : "#{student.email}, #{student.email2}"
    mail(to: to, subject: "The Richmond Read-A-Thon is almost over!")
  end

  def pledge_payment pledge
    @pledge = pledge
    to = pledge.email
    mail(to: to, subject: "Richmond Read-A-Thon Pledge Payment")
    @pledge.update_attribute :email_sent_date, Time.zone.today
  end

end
