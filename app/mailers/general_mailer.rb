class GeneralMailer < ApplicationMailer

  def welcome_flyer family
    @family = family
    to = family.email
    mail(to: to, subject: "Oya No Kai, Camp Westwind Portal")
  end

end
