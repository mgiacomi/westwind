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
    student = Family.find_by_code params[:code]

    if student.nil? || params[:email] == nil
      redirect_to :forgot_s, alert: "Email not found"
    else
      student.update_attribute :email, params[:email]
      cookies[:code] = student.code
      redirect_to :home, notice: "Your Login email has been emailed to you."
    end
  end

end
