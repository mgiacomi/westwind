class Wmgr::FamiliesController < ApplicationController
  before_action :authenticate_user!
  before_action do
    redirect_to :denied unless current_user.admin?
  end

  def show
    @family = Family.find params[:id]
    @payment = Payment.new
    @payment.family = @family
  end

  def update
    @family = Family.find params[:id]
    @family.week = params[:week]
    @family.cabin_id = params[:family]['cabin_id']
    @family.email = params[:family]['email']
    @family.onk_member = params[:family]['onk_member']
    @family.host = params[:family]['host']

    if @family.save
      redirect_to wmgr_family_path(@family.id), notice: 'Family details updated.'
    else
      redirect_to wmgr_family_path(@family.id), notice: 'Failed to update family details.'
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