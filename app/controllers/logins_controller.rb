class LoginsController < ApplicationController

  def login
    family = Family.find_by_code params[:id]
    puts family
    if family.nil? || family.email.length == 0
      redirect_to :home
    else
      cookies[:code] = family.code
      redirect_to :profile_index, notice: "Login Success"
    end
  end

  def logout
    cookies.permanent[:code] = nil
    redirect_to :home, alert: "Signed Off"
  end

  def forgot_email
    family = Family.find_by_email params[:email]

    if family.nil?
      redirect_to :forgot_s, alert: "Email not found"
    else
      GeneralMailer.welcome_flyer(family).deliver
      redirect_to :home, notice: "Login instructions have been emailed to you."
    end
  end

end
