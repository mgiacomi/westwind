class Wmgr::FamiliesController < ApplicationController
  before_filter :authenticate_user!
  before_filter do
    redirect_to :denied unless current_user.admin?
  end

  def show
    @family = Family.find params[:id]
    @payment = Payment.new
    @payment.family = @family
  end

  def onk
    family = Family.find params[:id]
    family.toggle :onk_member
    family.save
    redirect_to wmgr_family_path(family.id), notice: "ONK Membership Updated"
  end

  def week
    @family = Family.find params[:id]
    @family.week = params[:week]

    if @family.save
      redirect_to wmgr_family_path(@family.id), notice: 'Week has been updated.'
    else
      render action: "view", alert: "Failed to change week."
    end
  end

  def payment
    @family = Family.find params[:id]
    @payment = Payment.new(payment_params(params))
    @payment.pmtdate = Date.strptime(params[:payment]["pmtdate"], "%m/%d/%Y")
    @payment.family = @family

    if @payment.save
      redirect_to wmgr_family_path(@family.id), notice: 'Payment has been added.'
    else
      render action: "view", alert: "Failed to add Payment."
    end
  end

  def payment_delete
    payment = Payment.find params[:id]

    if payment.delete
      redirect_to wmgr_family_path(payment.family.id), notice: 'Payment has been delete.'
    else
      redirect_to wmgr_family_path(payment.family.id), alert: 'Failed to delete payment.'
    end
  end

  def payment_params params
    params.require(:payment).permit(:pmttype, :pmtdate, :amount, :fee)
  end

end