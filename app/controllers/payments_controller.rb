class PaymentsController < ApplicationController
  before_action :require_code
  skip_before_action :verify_authenticity_token, :only => [:receipt, :onk_receipt]

  def index
  end

  def receipt
    if params[:payment_status] == "Completed"
      reg_id = params[:invoice].split('-')[0]
      registration = Registration.find reg_id

      payment = Payment.new
      payment.amount = params[:payment_gross]
      payment.fee = params[:payment_fee]
      payment.pmtdate = params[:payment_date]
      payment.pmtnum = "Paypal"
      payment.registration = registration
      payment.user = current_user

      if payment.save
        logger.info "Saved Payment: #{params[:invoice]} #{params[:payment_gross]} #{params[:payment_status]} #{params[:payment_date]}"
      else
        logger.info "Failed to save payment: #{params[:invoice]} #{params[:payment_gross]} #{params[:payment_status]} #{params[:payment_date]}"
      end
    end
  end

  def onk_receipt
    if params[:payment_status] == "Completed"
      reg_id = params[:invoice].split('-')[0]
      registration = Registration.find reg_id
      registration.onk = true

      if registration.save
        logger.info "ONK Membership added for registration id: #{registration.id}"
      else
        logger.info "Failed to add ONK Membership for registration id: #{registration.id}"
      end
    end
  end
end
